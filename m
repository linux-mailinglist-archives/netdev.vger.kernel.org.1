Return-Path: <netdev+bounces-262584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCAkAtZYpWnj9wUAu9opvQ
	(envelope-from <netdev+bounces-262584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:31:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E48121D5922
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54AAB300832C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC338F621;
	Mon,  2 Mar 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xxCY8N+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C8330642
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443857; cv=none; b=cG46x2XuXA4t9ENQb7/wBZqbo1FHRytW6bYfzYgWaKrq7v+Rj6f1jqPJxHfp7xZQkYrtcCLmj452//nVg2kUASQHjgOrfdVgPtUIO9FZOR+TyePml7vWT5V1K0+7qrsQhSG1GRm4rGJv4eGKxzy6HRZE5WMyEAJcXweW6g21NQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443857; c=relaxed/simple;
	bh=SkQS32P2isxsZzN0Tpf5AFFSNZCHU5H1VsWyGV3O950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+JxwhkT9/lCa9lSNxOzPiJlh7tE971pRJECVJlkkUWZ1XvSaFCQmnqrMu01Amx0XCS31MqdZRjzfdePZOnZx2UY0s5RE28lsWAjs4DAqToE8MLc2RKSHy5tUfusMTA28RYRM52zf9Gu/7c07z9WpmZebnUaJXrDmXijddzdJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xxCY8N+f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4376acce52eso2811158f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772443855; x=1773048655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=xxCY8N+fbsjMfrshhj4gYM+chOalJaRweaJrL2wTpoGwmLZlUbumL7awGab7yxbwRV
         0mUaxq4c7qj1jSTnk3EAuIK6lSDxxdADCvoZL53octj513wTDSnRi4/R5cdaOh0EHvX4
         DGk6gTh2QKF990FGOy3pDqZQXPQ4Eyp2TM2CNZXQXLZShRMd//Y2twlzATk7O5n9oQev
         vkpPyzwkB82N5P/erQPzm165G7oovxqcTaqbSTAprF205+73zG3jdrNDP9/h9iAZcnG6
         GEwT8qqD5tqVlJ8g2KjgdD0phbqxtqX6t2w5BM7ieSuIOuD9fLRS9AwTGY2Sghwz6Dno
         c4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443855; x=1773048655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=DTm2vq77w5WkYE9I+V3vRSALslccnnHm42ybsWJqXWgZ7SX1ieVc3cEOPeuZ/R9Rp7
         vuey9PRYGLfu1KlszYMxPYWWIEEJ+imA+RleH5FpUG6cGTnxteU24oZu63FG13eRxA2G
         lf1WKqvQPYb6DzFecgaTa0GLr/flLjmCcRoOLoY1u5LjqnW7Dr/fIEMo3+yDFwRDXki3
         MH8BEfo8o68wRJfDAbO+7V4Y8GbTFwVS0SC+BLBRrRcRC05UrQAUIrumHloiGarOput5
         FOVsedS3uXY3t08nbaqknUZk9eXD/SNk34xhlNnXJDSj/ztik5RM4qGhr40w2kFVm5C8
         iU0Q==
X-Gm-Message-State: AOJu0YyeTL5dlZV14YhACsdd3GJjWXlAl25MuhySOGIk/wePGEJDWf4e
	fNuc9WkHWbxvJnkH4nfnfLjkiHI1qa9cUBWuzax/puLBkQGWA+8ax0Qu1nw7owfrHkg=
X-Gm-Gg: ATEYQzwVNCbAiOHt7J3zaH3Jqn0c1EyrHMIhbeawKRlBZwRqkUAdKrk9MVcnvuJVJ6W
	c6Ezegv1EiUD09qMWYToSt7jdkAP2SPcATganMy3Tb3PW8UZldzgDv0psxyV/q7RwhphZ7Sbqok
	aNy1XZZVDXYfbu0ZBXfs0O4XdJzJaBOTd2U3d7hry2U+s6f/Ug+Gd9RFoRh2LyW71Y6iLc0GUnV
	LlTHq6xVlfZLxPzZfTDaPFRNZbiWU2mteUn0uQL2yJxKTrVZwHMK534d7MJoOIpPKXw0Ie/NVff
	zsxd+tBQTpvDYM/UtHyGa1VU1ZVt4Gn3SqD4AErSAd6SiDstC9N5CChl2kf9LKcRhFwD51UuXJh
	UDWTMY2eGTrLgEo7JcMMhUA+But9PSQqB+DRwgJpecbcrU8Ox3sQvKx8NI09qjwK75ruIYKWUCK
	zJ32hjiKJoAVQcBy3kY1KksTbmeZnEGUA=
X-Received: by 2002:a05:6000:601:b0:439:9550:fc57 with SMTP id ffacd0b85a97d-4399dde551dmr19370651f8f.18.1772443854545;
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm15422817f8f.5.2026.03.02.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Date: Mon, 2 Mar 2026 10:30:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <cic5snbhrc4lvs5iyuddepj66nyttzpajgcjal4etqebjxlgqo@hwwtlbmczhr6>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-9-jiri@resnulli.us>
 <20260228150311.1a1ded74@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150311.1a1ded74@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-262584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E48121D5922
X-Rspamd-Action: no action

Sun, Mar 01, 2026 at 12:03:11AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:20 +0100 Jiri Pirko wrote:
>> +struct devlink_shd {
>> +	struct list_head list; /* Node in shd list */
>> +	const char *id; /* Identifier string (e.g., serial number) */
>> +	refcount_t refcount; /* Reference count */
>> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
>> +};
>
>As pointed out by AI you promised a size member and a __counted_by()
>annotation :)

Yeah, somehow I got false impression this is not needed for priv. My
bad, sorry, adding it.

