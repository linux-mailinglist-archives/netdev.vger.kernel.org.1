Return-Path: <netdev+bounces-269567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE0AIbkwvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:22:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C402CFDB2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F923301AABF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284E3DD50C;
	Thu, 19 Mar 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zWWlDmgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D23CD8C5
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940333; cv=none; b=ZgWx7JV6lfxY40m0O2zANW/QY+nzmDJh6aomw9bUsmGXwssJFJqi5noej52t3YbvH/rojoQSvHx5JsiODj/FMhRPFi95pJWT2MMRUTUQ5yqrFH/fIo6z2ZONiEKDFrq2hA10XiaUkIbUUiWm7oQcRLNu1ZCq5aIv7or3Tahy3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940333; c=relaxed/simple;
	bh=IR7aGQP6H1FkNuTxwHCiSTpeXnyxBpufz3KqtwJQe/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNfpuWZCFwRqep1TiehrPZhuEL+a992f811d6Vqy1JCO25q8Z1jiTZDtGXoHUZrqHh/4BXYRCBg/+h54aSlPZPSkJ5pvpwFI2NYdV7bAIJE602DGnRbXuDloGDx1YiZchPpv3/HU2/nqXt+IR2u+m3njhIXzYgxYr1BFRx2rSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zWWlDmgs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso397570a12.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773940331; x=1774545131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsJ0AYkPM8aVbL469BrHhoEE4ftXbii6Ku5SbAJ3B2M=;
        b=zWWlDmgsKkWX4pFGwjOCspH8I6eTa8lIrr1xj3nINPw4RiMwirHI9zbT+PT1YG1aza
         HdhNZKI9ONB4TvDeSl3wS182OmeS31nQOEP9CLAH4F1ScQ/EOOO108W0E+kNuS0W8l+n
         1r8tG36et45S6wVTHI0lAdpfBwbkiXjLi/1Hz8CUhDHQ1ASlKB2awaK2bht3MkHMwqzF
         J5jvelKc0X0jy9WShVY1UMPC36KL9C4g7z65QkY/zq+VKMPTzzk6doORfP2WwCit6UKg
         r4cqZGCnT9cjyMS2NPXr/azbyC68+PYXsLeY06+IvuhSO0VgfpMeuynNvhc+6oMvW7Hn
         toaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773940331; x=1774545131;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsJ0AYkPM8aVbL469BrHhoEE4ftXbii6Ku5SbAJ3B2M=;
        b=kFe1vvx2O+YYyliAZnjIUplI7gMJcG73SiNi3d96TB0o4doztMux68CAOwGfESKEU+
         LL5tFPDhRwJ5689AKC0mbmiTvV6HKhNxkyQIwNj4k1M0l+6vpq7EDlt7vdpuQQMoX7Dr
         eq+cnawZsMIZ9aMDMY3EtL6pq5XMSmHrW20BEeHq09Zybmd7MIhyRQ6/iZsYUemiocwB
         cy98qgpFmpaQHGW7zU8DH0NZiBMuDTwD9JwRzp8tz/MGNXSUX1Chpt1hzUsqoLMZRghN
         dkffD9ZDzyqJQbmq6HCid6OYaqMahOAyGdv7q67Iu1WGtUhUqEuUzg/FYVzwLL+xFDLv
         2dTw==
X-Gm-Message-State: AOJu0YxNinjVHzGZfv+a2jspyBXUom7mbvU9I3wfEf53qEAUQBrjtc7M
	EKk4H1UIA6k57EfPmW/xbVebs5/KgVS8TT8qJpoPA/HAxEk3rjKXIRB5zd7mLLhUVMk=
X-Gm-Gg: ATEYQzzVOujJBwbrYk+/it7EBsl6OJQLLL9ZYG0wmvUNu+TP6eFNhos5SHSmVad+ddl
	UdPDQM4h4mxroBlppwLIqPhSGIccsm2RNuPZVBeD1d/pwH+YiXWe6mSYMfvRw7DlEcSudPfsvZK
	ibqzLrnmiiKIDLwxwxJ9Px0l6NKesfXxRgzllvZGRKVq6e6Ev14USpjCmDsh7pYPZET3ppAvr48
	KqELvLDCC80ZAJmcLigd0i4jHm6iovfEaYHFDdkk5lQxVizcUFZywvBcQ1NSG7sUkP3YLuHuZ8l
	0lvHGt+QuV/Og0ispdMhIxaLloo1OmQ2vj6wyaZFrlaBIcTUO0GZNLHqY4CacmCzk5AA/atSbOD
	lMAVkXNFaMhJSMgPrsNKeiLO2R+M7qt/6ZjzEm1o2Tgq2MG0lFjEVR05H1ELNxDGvpvTwMp+c7t
	cz+ZRL
X-Received: by 2002:a05:6a20:3c90:b0:39b:87f0:758e with SMTP id adf61e73a8af0-39bce9b4f21mr174045637.8.1773940331489;
        Thu, 19 Mar 2026 10:12:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2ddsm2326a12.24.2026.03.19.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:12:11 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:12:10 -0700
From: Joe Damato <joe@dama.to>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v3 08/12] net: bnxt: Implement software USO
Message-ID: <abwuamlgUcIV43A6@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260318191325.1819881-1-joe@dama.to>
 <20260318191325.1819881-9-joe@dama.to>
 <CALs4sv3i9qk879+OFyj1Ecq6-Kkuuu=GAY2hJCFYOfFg3sy_Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv3i9qk879+OFyj1Ecq6-Kkuuu=GAY2hJCFYOfFg3sy_Jg@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44C402CFDB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:11:03PM +0530, Pavan Chebbi wrote:
> <...>
> 
> > +
> > +       hdr_len = tso_start(skb, &tso);
> > +       mss = skb_shinfo(skb)->gso_size;
> > +       total_payload = skb->len - hdr_len;
> > +       num_segs = DIV_ROUND_UP(total_payload, mss);
> > +
> > +       /* Zero the csum fields so tso_build_hdr will propagate zeroes into
> > +        * every segment header. HW csum offload will recompute from scratch.
> > +        */
> > +       udp_hdr(skb)->check = 0;
> > +       if (!tso.ipv6)
> > +               ip_hdr(skb)->check = 0;
> > +
> > +       if (unlikely(num_segs <= 1))
> > +               return NETDEV_TX_OK;
> 
> goto drop would be more appropriate?

Yes, you are right. Good catch. Will fix it in the v4; thanks for reviewing!

