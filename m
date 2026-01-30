Return-Path: <netdev+bounces-255266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OipMl8jfWnPQQIAu9opvQ
	(envelope-from <netdev+bounces-255266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:32:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA3BECE8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBC7301159A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1530275E;
	Fri, 30 Jan 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWU4cc14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96B2DF3CC
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808733; cv=none; b=oG+x+BY77luMmumgTccTZOdDIwChHzB4S7XHPeIJazUddBetaeLYhHrgrdx1YroDNPY2rneiS3ZddinKGKOsWznG2U3fgz+w9rbUxEGZCYp8wwgRaik/FmmBkfIOJWGiMEMoaDLW9c5rU3TWnwL6bjFKAsRSipk2+XenPty94Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808733; c=relaxed/simple;
	bh=0mCe4gBlCnuistQ55dGP1BpGbdSeZQWSzm3+Mp1u9LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmOo7MmErdTA7JwktOiADIE+7q0uc02uxBWbVB80b+pu+FG1RypF9aDQRtrNJxrAbBqNPmwmK/mkDL0Z1KDJwE6y8j+KE49uZyM6hUCeb9ap4jBr0vkMnGag/Tthij2TQBV540RoTd93s6nV6LC2DBZ4co23+tkY7cCDnjnROY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWU4cc14; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7da62b487so1260489eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769808731; x=1770413531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyOqlCVXHF3sQdT6Vx4/sdnRG05lWhonX9HWVVa6DWA=;
        b=iWU4cc14GGZS3cSeYgOamjQerLy4kM/k/qzAqyVurLLLy4RRWkPfFVuwAMj7ntIq82
         k4Jz4YSKsfQORE1JiDakqtlGnPkDxv5CXITArvgNljpAeOnTdHcQH/FQ4J+urDhq7CVC
         N0njBTgXIyHk6Pj3/VMgoidcIAjHYtCHd6tOgQZDPT0ZqJgdRzDGUvzpCUApX7clhjyP
         xcSYoOql6cKODKKhkS7oSX8bXEd4Fp4kFZnsfj6Uf3Al+ZU8QRqTXN0TG7dJQpEYEIO6
         CDgOwcq2MRy26ZDQuZVTIxZ1538EcZl9cXaQ1kLxdC7EfW0ORLKfA/OiqFAAgYzOJFUl
         dsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769808731; x=1770413531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyOqlCVXHF3sQdT6Vx4/sdnRG05lWhonX9HWVVa6DWA=;
        b=CdAC6LgrBDat9m5UzUN82BTWKgW0ZW+BTcnXBTlg6uWc2xgcayK1EWihe72D3RUCxh
         Sb75loMY0GKQZR5Z9T7ExDflVQmJa1DRmWK2JQz24KTCbGkYT6fo4dqmUJbFZQIxGfrn
         yZp28NB8PSKGHezzuljdzjJCNlpPxUCLszB0u9GtxYimvwR1NqhyJj7yVOifBeUVN0XF
         ++dckwpnBpfv59MVBCkpkiZmpituUHQhePQ9KoNl2ezTe3ASGTC9wyno8Tcevn8kzca3
         sPMPz/86QnldgSsUwK/NORbWaJkcEcFTvhozs3xInLcuRtPYy1dgIhIsGDtxGNW0V7hD
         Yz9w==
X-Forwarded-Encrypted: i=1; AJvYcCWh2CsFDbANJjxG/+sHFLQ9AkEEgwjrSjqZ88mScCj/2E+GR2OFtMh+evo7dLTrO8gzqa4qvX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4e1ipejGlSs7jSSp+a3MNwIajylhSIMnvNBmwdK1ixxd3RsVs
	W6Xbfd5O8yVkEWIYkiB0JOo03znJZmakN//cWqlIzk/rF0SshsxMHg4X7ylCPw==
X-Gm-Gg: AZuq6aI+EU/WZrLVEwDLLCaMFZVI/H5uDq5XnkmYnADo2gLdFjx7oY+bbhZEbsLsB8f
	M1yz0r6GCctr1k9bpgQQgLwn17uog9QiyY1BJb0XfkPGbVdNur2G9APbxdd7S+VRdZZ3bPzwUIG
	yglyP/BKXwWVqmIq5+bGuJYULAEW5QCNJ86WecqDcDsPMXMv2BNl1UzPOHSIpBlkmcpXZh3X3Wi
	3zMPkLCEmA8VxCXCvT7TGXSVplzG2sEL1ARnsxFhNjouT+i6nIVS2uJyiBK8TaBDHt6MdwmEA2e
	T+If1Od+VVR5E26RgxcCD6W0XJi4zjX6MXmMD3If7ATFcR4aqnHkbO1o1U41NrEs+QwefthGvk6
	Y1z+gHmhycrNN5jlVtBdSY+jDEB2pR7AJITlY9LTKIROXwujUEdyUFoxLHLhhjSJ+TEXL74Jx6D
	fXSswkJbpi4Sj3/2c=
X-Received: by 2002:a05:7301:1293:b0:2b7:9934:c42e with SMTP id 5a478bee46e88-2b7c8903d11mr2046756eec.32.1769808730817;
        Fri, 30 Jan 2026 13:32:10 -0800 (PST)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abeb6asm13751252eec.19.2026.01.30.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 13:32:10 -0800 (PST)
Date: Fri, 30 Jan 2026 13:32:09 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <aX0jWU2xA6GwWhvY@pop-os.localdomain>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
 <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
 <20260127091556.052604cd@kernel.org>
 <aX0aVgCBTGpGYaJV@pop-os.localdomain>
 <20260130131812.7f9b1eef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130131812.7f9b1eef@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255266-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pop-os.localdomain:mid]
X-Rspamd-Queue-Id: 27DA3BECE8
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 01:18:12PM -0800, Jakub Kicinski wrote:
> On Fri, 30 Jan 2026 12:53:42 -0800 Cong Wang wrote:
> > On Tue, Jan 27, 2026 at 09:15:56AM -0800, Jakub Kicinski wrote:
> > > On Sun, 18 Jan 2026 10:07:37 -0500 Jamal Hadi Salim wrote:  
> > > > On Sun, Jan 18, 2026 at 1:16 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:  
> > > We (the netdev maintainers) had a chat off list and concluded that it'd
> > > be great if we (the two of you and one maintainer) met over VC. Either
> > > technical solution is fine, but we want to make sure there's no ongoing
> > > animosity. No agenda for the meeting, just want to make sure you can
> > > have a friendly chat. We can talk about the weather, AI code reviews or
> > > everyone's favorite animals. At the end of the meeting we can either
> > > decide or flip a coin.  
> > 
> > I offered people involved here for a video chat, *check note*, in
> > 
> > 26 Nov 2025:
> > https://lore.kernel.org/netdev/aSe%2FIfNSZBTTAfTA@pop-os.localdomain/
> > 8 Jul 2025:
> > https://lore.kernel.org/netdev/aG2OUoDD2m5MqdSz@pop-os.localdomain/
> > 
> > No one responded, obviously.
> 
> So you should be happy that the call will finally happen, right?
> 
> > Jakub, please let me know how to talk to people who kept rejecting to
> > talk. It is just logically impossible to me, and I have tried my best.
> > 
> > I wish you best luck for doing so.
> 
> I sent you a link for scheduling the call off list.
> 
> Which part of this process of scheduling a call would you like 
> me to explain further?

I have a better solution which wastes no time of anyone:
https://lore.kernel.org/netdev/20260130212021.46610-1-xiyou.wangcong@gmail.com/T/#u

Please apply that patch, all the problems would be gone. (Nothing
emotional here, it was after a very careful consideration.)

Thanks your effort, Jakub!

Regards,
Cong

