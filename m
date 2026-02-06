Return-Path: <netdev+bounces-257507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGUlBpW3hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:42:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC94FC2E7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5AFC300D993
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BD3612EA;
	Fri,  6 Feb 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IQXaoLDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C093612CC
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370955; cv=none; b=IFKqpOoqv5rrSRRFK6YkNH4jNNs0MRD2BVcyyFqO0QnHs/oFDzBWNLof9sx0zqDwQltesnmPITIXvFakI9raPBlHJJjdwM3/P+qRTnuy7mc6xmQwJJhvyAk5e0lY7ORsTGQQ8kexWpnFRxrBSFofCrT1AwyRLF/gwMT6Bmo84nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370955; c=relaxed/simple;
	bh=tko29gTh2LLoTYAs4568Z4zBWZMgYShefsZIF5Fo0Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLkeZPjaD8yXVSKoKP2Qn1NKYVTggRj+JFHwkP2B411mwj93BtAXrsBLNvQ0iAZgFMF5uRHRCo4xmqn4vTUPMiRt7nhxlgtoQny52vmlRmPSopnITAtwigvtW9T0vh/kfOlCXnAL5ex/VKlmPTI/dCZOK7UAsR9H5b/c3pgYTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IQXaoLDK; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so21639665e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370954; x=1770975754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyNDbUvGFsSfZP0FW1tm6li3l4kdarvpP/zPKhRvGdY=;
        b=IQXaoLDKFjHthosSnThWePVKl1dPx9eQLoXjQogTiefOpN+1Nhcv1cwIwOxXD0efOM
         Sc1zlYJ5KjoD7FBAX4zj2PyeOh9k6RdMk3JVofUjip5+nuQgy6r4arWdk0w/QaNvCEad
         fi3n+mb3ZpQxO5PRMxYpRINEOcE+nWyTISbq3AQ77DxvQyOS+MZm8xZx04OsAKg5nEcr
         IV3lbl50pc8Seet8k9ECZ+Hee75zbtgolAajF1okRTlEBj6ofbVjmd9kMzvxq8FCzkUz
         tcxX5UlU03BIvl0TSN5QKsj8YXh4gwTn/F0h33eIcSkJlWxKt7OPEgVpYm0N7J51+xz9
         UOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370954; x=1770975754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyNDbUvGFsSfZP0FW1tm6li3l4kdarvpP/zPKhRvGdY=;
        b=C9JHb3fWlPzacMq/TVraRei3eR38OWIlZSRdAQT7iRq9SKJiiCKZmAvQmjUGYQxX1f
         EyKLeeQENjjRS/cK/OG5QRHDbbGjIA6RD3HSUFIWfYKY2t1XN4F+GHE7EoFmYRhQSRlf
         D22UnvVU7CMQxH1EKeebfjogFKKtRet2q6X2M35wBVH6ULQlRwjTSzdavHAotRCGKTi/
         +dG0F0u3diYCWDl+nxlM0pTPznhzwMetm5y795btwm/TviTe8fFux/d1jrQCqvYa4QJh
         72HGMy6881FFDWOg4yDVTbe6Ot/Z3GgEhD+Crkp6WfDkqvsQ8hSMhWaQy3msYwAFbps/
         PM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXITj6eDY/pgt4ycyM2i6LHblg88lgpUrXSrIFuBNmLbaI63AW/DmiV4SIu2lqzGzr+oUabbKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXV4Zg7YKQ/2Mk2hDDUpxumZ1y6EZXg3dfpEDLm1XiTa/EteZ
	LiEjHePngJZdumH3dzX4zvBEnM/8AMzK3VuFL9WuX4etfNB8NdBJjRXJ2OQgx9A8hBk=
X-Gm-Gg: AZuq6aK0J5lGbHGbT38Ei+k3SgClTGmib9lGfJjKy65yoiGFvdwecosWr+8WNRCLnne
	2vvc+8iE/GJKXoVEyVsTLSeSci3yeoFp00J4lbewV/LivnDUeyqviCKTPbtGAy83LOb/GlQyQc0
	HhT2Je3hvVPoc6V3GhzfXcQqPzQa9YnLL8jfNZwgqTd6yXOgfMx7Uys+aSyfTEeiKXfGU9RzlW5
	iXo1dDfzd2M7YcE0+rT47ke4WC2chHgtINqjA1kzHrYd3TdGrOiNirTKsfzmIovMrGdQ+VJI7Lf
	nFTsVOrNgTV8EAmJbZzOCMMjVjHk50dQTalCxKXfGpfF0H3i/mpxDppufb9dGiPRASLJnHTf/CV
	iQqJkj1zopmGtiOV6ZDi7sXBuzqUfDvXYfO1oxD07WhVmJWQJ+wNTGVIy4lVxO5Ih6x8rBSFC3m
	1JBI45Qjk4MJ193WsgGEKqm6Fv4Wvu0A==
X-Received: by 2002:a05:600c:3f08:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-483201dcfc4mr31888195e9.2.1770370953809;
        Fri, 06 Feb 2026 01:42:33 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483228ed4f8sm24728865e9.0.2026.02.06.01.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:42:33 -0800 (PST)
Date: Fri, 6 Feb 2026 10:42:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V2 7/7] devlink: Document port-level resources
Message-ID: <djpsyhzawzquyjhq2dgepf5twxi7fwjjqm5rjwcbwkn7ub43k2@unfqnj2fx4ah>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-8-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257507-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BCC94FC2E7
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:33PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Add documentation for the port-level resource feature to
>devlink-resource.rst. Port-level resources allow viewing resources
>associated with specific devlink ports.
>
>Currently, port-level resources only support the show command for
>viewing resource information.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> .../networking/devlink/devlink-resource.rst   | 36 +++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
>diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
>index 3d5ae51e65a2..c2bb7e429a26 100644
>--- a/Documentation/networking/devlink/devlink-resource.rst
>+++ b/Documentation/networking/devlink/devlink-resource.rst
>@@ -74,3 +74,39 @@ attribute, which represents the pending change in size. For example:
> 
> Note that changes in resource size may require a device reload to properly
> take effect.
>+
>+Port-level Resources
>+====================
>+
>+In addition to device-level resources, ``devlink`` also supports port-level
>+resources. These resources are associated with a specific devlink port rather
>+than the device as a whole.
>+
>+Currently, port-level resources only support the ``show`` command for viewing
>+resource information.

As this documentation should be kernel one, saying "show command" sound
odd as from perspective of the kernel, there's nothing like that.


>+
>+Port-level resources can be viewed for a specific port:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show pci/0000:03:00.0/196608
>+      pci/0000:03:00.0/196608:
>+        name max_SFs size 20 unit entry
>+
>+Or for ports of a specific device:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show pci/0000:03:00.0
>+      pci/0000:03:00.0/196608:
>+        name max_SFs size 20 unit entry
>+
>+Or for all ports across all devices:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show
>+      pci/0000:03:00.0/196608:
>+        name max_SFs size 20 unit entry
>+      pci/0000:03:00.1/262144:
>+        name max_SFs size 20 unit entry
>-- 
>2.44.0
>

