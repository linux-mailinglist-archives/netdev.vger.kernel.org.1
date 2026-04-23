Return-Path: <netdev+bounces-280654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMp4LuTQ6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696544E3B9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1CAA3023D82
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD833D4F5;
	Thu, 23 Apr 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecoLtfXe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="no6V8h97"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4022FA0C7
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930931; cv=none; b=qUDjqsOdf6YPIO7A1MTZHFOxYj0F2aqF6ADv9dyRVwkhJyHsCZ8prWJMmubXqWoS71YDEZ6uwffuoGzc28K/VOzOvS6V/4oW1SrwYamEMhDVjcUtmQ96zzrUmliDU3xW793sRIg24d4/KCWPR7X3qEE4YEADiFg8XVhVwNCtXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930931; c=relaxed/simple;
	bh=L2WN3Mdkt+PLvtN1w07nhMKHoYH38g1usozRivR3K9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkufyNf6NjI18Y/2i0iJbbtkaMSE+W/1IpyX6c3q0SwJMcfP9+0oycm1AZj4qrTi/+ZOUcIabUwOq7Eheobqb7bojtO87mF7KZ8KBJnDK5UbVVtgFfDmtsg2AN52aq4dpmbkufmHN5mqFo6Hvh7F09LZmq7WxYovdNpDOi2s3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecoLtfXe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=no6V8h97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
	b=ecoLtfXeT8yE7zwVFzHDM4ni+2PCPl76kjsodP3oeDSQniQYsxAgS1Tb2fNVMQMagYK5JK
	hskeqpusb6pc+qdOmIul/yFWknfqUSnI2a1jS9Igh5CnPDNt/y++u+PFt2QsY9aAPSMdMn
	4YP1wEQ9q1FLwwPAhlhWQmCAPh/uELg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-jujAXU9VOO-3OG78iTggJQ-1; Thu, 23 Apr 2026 03:55:26 -0400
X-MC-Unique: jujAXU9VOO-3OG78iTggJQ-1
X-Mimecast-MFC-AGG-ID: jujAXU9VOO-3OG78iTggJQ_1776930925
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso5122553f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776930925; x=1777535725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=no6V8h97ykgC6cpJgVuBQ/LRCYpO3tCbV/JSThKrn0vmzG6RWFJ9nmN8vP9Ma4LUvO
         q12PgayYwC/MJAY8xE6rWNIzmKcXBt0fL6TtR2r/YeEtyO4P3w9lb49fxNWqxw5llugj
         0K3fo8uJ4vL5ndRznkJII771++DWXv4GUQwVtZNHY/z3o5w9WIXOfug1EH44GSr9TT+Z
         m5q3+4CxI7jLJkggcLp2lkQ2xWTbkvMpDg1r4qIVALZhUe0HS4UD6+GkhwwKD1mm5xsr
         99uDof/2Fhve5z44DPsitcqqp7hFXBHPCIRNJp503T2aVF48D9dN+t4YUFoAeBk1g79n
         O7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930925; x=1777535725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=Bpn38gYI6E5AtXgPfQWR7dcKtTmg8TnXH6JblkhhUzCPmz9Gs+Jc8ZMS0weoWbXP3k
         H5MVgCwYprPAn7SCRQde3DbH1FBfKoB5kVmD2Z385wROvLyYkXtBzs7gHUxXXXQxRo+U
         4IFfshn3EjmJ24qgPGP/WQwjxpjGFAzXKScXeA6B6hM3NYcxdJvYMC4yrBRDfqGZ3bZ8
         8HLzTvv6FHLflHzMvdkdz0h/ttOpTFcE9W4d6Qp2BfW1JOrVBxjtfP4RhSuJAoD58xxj
         3gOVNF0afxZw4IeCOwH8oqoNLezRG1lCGK8PLMCaMysoX5dr5BkPvXH0HAXvjRgG1uNS
         hBlg==
X-Forwarded-Encrypted: i=1; AFNElJ+dJIJiGuEYrV4avOVaK6G2eLcDkwE7t9aRX+oVFfIQYXwIt1WpR6jMm9xqLVm/cYEXqqY6J4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF87zYbFYfjb0VW6wuVMSmmwmK2PZWjKnDkxIqcD25eY04rJc9
	4kwlxWY2mSF3WoTML6C3l9joQp0H4HoD9kgCuFj/92RvDzgzW7xDuFKiUSIcwkt2dluJ+tJ9ynb
	OTkXxnL5AK+OsPYLOvJRtk7iVkKoEZBkMZEWg3/qk2BNdGrUaAP3tUWYdqQ==
X-Gm-Gg: AeBDievy2QrPan6B8euz6mnA+RMQN0TkCfRIP8nzrsjWl6crI4MjXrcv7vrKyJKX5oB
	FFiPWiIvH/2Bv62pX6MvHsPiJPSg6XTrA9X/RTUqPIuovTdvoPVOO5eWVehkUXo4ja8hhtRw2DS
	hSyvt7TjpOUZTNvQjOXhhUHmQtC69ZM74iqVQBnUeFGNi+5ueuwryhjb0LqtcQJLPjoNDCr51bw
	gaBl9TyG60l7dFLWvAGjg7+TAUf3kuMbxoxy0pEf8Bqsvs1rfVV+6dAWIaGUVQM31sbkLQot+Wd
	7q9RlS943nRrJlxx8DcG+imeJ2/VhZ5UiMOCPAdqTy1E9K/NKvBUXxXXfmAZqVdMOK+WkAy3lsB
	s+Nk2cc1QbRV+XI2ktc+YRNVuMw3VOu96fixxqYnu9wwRU82Jt09kFHmRsi9BnhNI/wiq9KBcS5
	TTPOrgNw==
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520272f8f.22.1776930925143;
        Thu, 23 Apr 2026 00:55:25 -0700 (PDT)
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520207f8f.22.1776930924637;
        Thu, 23 Apr 2026 00:55:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm2933844f8f.26.2026.04.23.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:55:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:55:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aenQQpYW6j0BoC69@sgarzare-redhat>
References: <20260423064811.1371749-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280654-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3696544E3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:48:11PM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
>Changes since v1:
>    Integrated comments from Stefano Garzarella:
>
>        1) access 'vsk' directly:
>           s/hvs->vsk->peer_shutdown/vsk->peer_shutdown/
>
>        2) test the error condition first and return -EIO for that.
>
>    NO other changes.

Thanks, LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


