Return-Path: <netdev+bounces-256293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAmzHzz2gWljNAMAu9opvQ
	(envelope-from <netdev+bounces-256293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:21:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4DD9D76
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0133A3010692
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA93542F8;
	Tue,  3 Feb 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="godMEitN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D60331A4B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124460; cv=none; b=r8xVzYbrs1b3x+6FJpvd/rkuLGG/D0Lz5JrmVDhnIAjCBXyrmwD5WdsxjcuZCplDLppwnax+c4lbZMtFGorxSxOBNZLxpARmmFnX+T9UNgzCTfbe+ePa/25h+jhwDWCIdYyUdNqrqvZKx3GauilTuQ6dV8/kxrACS3qf+L6eCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124460; c=relaxed/simple;
	bh=h5+V5TC/L08AhB0eavwtmtsXpGvx/7R9Rpq9HaDB/Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqD2GZIXU/KHkfLd3APAGGaJ7W59YLmw9KQV0TZrQ+eNdr7VPYlusO4SxNzV9Sw6k2Ovs4U5miGfGQgcUZmHCSV1fgi3aRSiog3ZQxU/p1HAqN87gFekKzaLJEN4l60KFCCRtMgZumPWQN8aijCdIPWxvifLXM8lupqD0lQ0/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=godMEitN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-435a51abad1so763628f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770124456; x=1770729256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icamyzUNZPVz39YQVo0CsY+rqrn/GUnm7cd1J8DdjEg=;
        b=godMEitNhxK87GDexS25IV825lahUcMZnE8slOU7rwx31cePQnUfofm9hg9PObmAfS
         7dqmyG3d4VAyr8BoPme7NKwAwfmRW4rY6k+5lxbdCjrVyzeIi5Gl31JAuHr6M+u/tPbP
         03/fAGs2Ga9XGMqVXbe7ngwT8mt25SoHoQ2UlLkgNfYg730RiR+f/8Qi5BYP6jf5YN3a
         haqHzjj3djhCAxBpGsyYg1ZJv/UcYwfp5aeOUZbrg/vD5CEv+KvDylrB9l1jlZ0jZQde
         Yh4s2I1lKRnTH7BTB0ElL+Th7FMdbiCrX9GbXw7LQzXabZTAGWHCOkU2U4ClJ/YDiCg9
         bk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770124456; x=1770729256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icamyzUNZPVz39YQVo0CsY+rqrn/GUnm7cd1J8DdjEg=;
        b=vzVodHtS2RzirlFxsrv/6p3wQSWIF+v/I2Sb6R0yY/9B5ftKD5wVeEEV5zpUQ7f8cr
         Lt3ja/X+QoWR0R7HXMqxjzZRLZM3fRqUPG+Xzldvpd9ARfdEUWVLT+fr+EfsV7NhBC0v
         eLQVwhEvEPd1oac+8PgXecd+W6FLcFXlXytBS15U3niD/x5O1/wfXy3Vcpa0EYoPoVhs
         L4Op3l2TCN6IBRWOjUcJvl18ivXeaWEHU+Ui9mJiip9mOrpY7x0mbqaWfi1doFaROj8n
         JHYe0XpJUbkRTOODljYtRorvj/7Nr4J7+Lft/UtSl4FuOgoXpZn8wA/Ph2iAxYLk999V
         MG2A==
X-Gm-Message-State: AOJu0Yw0kqpBOvT3I13vyFR9IWvpStHIG/CV892U/6W80/wbbBITID8f
	UsMm9O3/tuZ/Ford615d8sIWaf5pbaAcMYUsBg7e7MllSt/Dajq5jpcl
X-Gm-Gg: AZuq6aJCzlcLc+SyzgpvVHZFE8pt0ULEN2dSdmrijlp+MvJ5wLPK8zWfkofOl1ZAM9r
	/AWWxL29wZ/rW5+1HSugO1LQzTWTHEEzSovhv9zh2QG9kNXM9IDHFXol0okLbFyCLoLE5PnaGEV
	XrLf7cpFdQVEXoz0mTpMSiWsjyNxVW0Ok8A6udzqZv13Nt78KlMOWET7hMWIJ4lCeGD8YJIh7eu
	nIAOy9O5Htlx7cA0H3hxZ36CdyQg+4NkITz1maqWC8dBIfeu2sUxz2Sqe34v075HUpI3LvDgoYV
	DN8pzQBf28gWVhDhe90eNDyb4OuEgUdSDqYdximjXLZ8604KItUPrPn3F5apwCNucanA40Aqv1b
	7Mda36gw5DpB5oNHnt5Y4ntbQXkaT7YYb/BsMgZP7Yw4KRjxaqGUkKY4fK+B2LZpBkJhrIuYIpt
	bwCA==
X-Received: by 2002:a05:6000:4205:b0:42b:2deb:829 with SMTP id ffacd0b85a97d-435f3aa9fd2mr14186721f8f.3.1770124455494;
        Tue, 03 Feb 2026 05:14:15 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:618:ce2e:8316:5a68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm51628516f8f.7.2026.02.03.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:14:14 -0800 (PST)
Date: Tue, 3 Feb 2026 15:14:12 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] net: dsa: yt921x: Add DCB/QoS support
Message-ID: <20260203130702.2rwzhbjl22pjjjt5@skbuf>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256293-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94D4DD9D76
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 10:18:46AM +0800, David Yang wrote:
> This series add DCB/QoS support to the driver.
> 
> v5: https://lore.kernel.org/r/20260128215202.2244266-1-mmyangfl@gmail.com
>   - fix xmit priority for tag driver
> v4: https://lore.kernel.org/r/20260127020847.1482724-1-mmyangfl@gmail.com
>   - change the color for DEI bit and add a comment for it
> v3: https://lore.kernel.org/r/20260125001328.3784006-1-mmyangfl@gmail.com
>   - fix port_del_dscp_prio()
>   - split yt921x_chip_setup()
> v2: https://lore.kernel.org/r/20260122194233.2777550-1-mmyangfl@gmail.com
>   - make DCB support optional
>   - refine with enum yt921x_app_selector
>   - add missing dscp_prio_mapping_is_global
>   - fix pcp support
> v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
>   - rebase
> 
> David Yang (5):
>   net: dsa: tag_yt921x: clarify priority and code fields
>   net: dsa: tag_yt921x: add priority support
>   net: dsa: yt921x: Refactor VLAN awareness setting
>   net: dsa: yt921x: Refactor yt921x_chip_setup()
>   net: dsa: yt921x: Add DCB/QoS support
> 
>  drivers/net/dsa/Kconfig  |   1 +
>  drivers/net/dsa/yt921x.c | 310 ++++++++++++++++++++++++++++++++++++---
>  drivers/net/dsa/yt921x.h |  55 +++++--
>  net/dsa/tag_yt921x.c     |  89 +++++++----
>  4 files changed, 393 insertions(+), 62 deletions(-)
> 
> -- 
> 2.51.0
> 

From the perspective of API use this appears fine.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

