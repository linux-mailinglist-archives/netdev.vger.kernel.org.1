Return-Path: <netdev+bounces-272264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA47NtepxWlUAQUAu9opvQ
	(envelope-from <netdev+bounces-272264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:49:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF1533C1CB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3851303450D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4A1F5EA;
	Thu, 26 Mar 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok98R3fM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC802D8DA6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561746; cv=pass; b=ZfNNEXjeHE4xv6NHfSOZpq6o5QYxZXQRfYnVaXEg94hnTzIoXvF+Dp5WgzdHdHaAAE+PKTqcysDbx/RhbHUwEZ31O5RDfZ7fiLraQu6A/HUr92i2brsTSmR0XgLzstTyPLpRJqgLExgbOa3SL49LpEU4CMJeBkeWciAw2YUhC3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561746; c=relaxed/simple;
	bh=DWb6NDjjhzhDkeF+RBAi3Ju2eFdvktKCdBS03nVrDeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKfecxS/ZQu15LA8oCbdYDeCMomooloLp7KZHpeXnfuP9jziXd4jFyOkt7MTH9lBAXrZcUBExlNRUH8UNwY99JKEhIJnoK1mfo3fdWyGA6C4fQY9128rMU5Lb81uIVuW0MhTcwmbh0MUGBeSvElMwbiwfb0u7XcHZ7FjDkFnwa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ok98R3fM; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c2239140aso598006b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774561743; cv=none;
        d=google.com; s=arc-20240605;
        b=k4pU+q32bb7aGMkdQCzrerzud/BG2kN20Lc/AnLwOGGySETlMFIdc0i68T2I15aj8W
         jPIaKn88H8fJ+hOAXVPbN+B6njzgB09/D6CwPniSOoMlIVzd2sIV/HcfIJ5oVS7+nBCs
         jOQK7phy2HxTjJR/SB7DukvHhIiHwMl0QrxPhTfDzeiIc4gE0iFtLSOfwFQBSHWlXZeT
         7IK5kcbHRmJlTBE1qGNNTOkV6oTi/eoM3ryprA7+Z9R31Tws6O/CjlT3vx5lq0BygwYl
         dj+y2LUzL+H3aeAO91qK7nktayBSYPH61mm0xy2rpRNckECOeEeL7J41Kzh2kKxnLegg
         mFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LcNk0BhBpunqYjg8xevwO9GWhKeqxSm/v/1iUobDQcs=;
        fh=DjfRwEVGDuSsUVbM9+7i73ZZeS57ujBcVvhT50Y2blc=;
        b=PFSu/iOlJdiZGdgz5POkqyFN2Kxs1MFvjKdS08vHrjzPOJidZIJuyEpei/hHX+1xP8
         i/GUHbeBY1G+pvWbfIr3BEtSOULrj7UMeR+q4RsAgStH5OOpmjxb/GHaQqjilAKZWIQw
         UdZEZvslbqnNH8GZahJ3hO2WPG+3E1KqGnS+UVFEjs01NG9gzmQE6Q5uQ4C+aBjKi9TL
         eSKj+sWcwtewtZq3k/KgCkrCijZ1lXPnoVLaaXz85sVT2hzk59sbDFR2qJ+CZFneUj1l
         wktA9mgOjd06MnYGH+D3o+AMUaU5aIxI9XH1AUeeP6BAFivauh4dXa2BHoApg7HnCvpw
         czbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774561743; x=1775166543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcNk0BhBpunqYjg8xevwO9GWhKeqxSm/v/1iUobDQcs=;
        b=ok98R3fMT/28v62XhhGk3lcT2qVPm6pNyj18euczkiLhqEsgvTbV6bJoz+Gf/zdewU
         lKpvnjq6qC0+gcTNYzZZ7E8qevJO5HnhbqvPLEj6X1Gqu/lc8Df+pQcHvVzPyvEIulTa
         QZKuxTeyBt4GaC+UJNSQF2UGqpiKjsJWzBrPnVwrhvSwUwkx5Ajy5PDSYJk8HQ7/93Ov
         Dt2kQxam5dp8CVhSp4HcQ8N5qW6eUGmKQVruZvX6wDm6NyDE0nFgpQnLRtI8jSM3+6UC
         mOuj6F96BgrQY1y/cHxf8Hk5J2AFlKuLW2ZqQUkZCNDs9wiNaBWopr+URniQW2o6T8qz
         lEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561743; x=1775166543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LcNk0BhBpunqYjg8xevwO9GWhKeqxSm/v/1iUobDQcs=;
        b=Tii1TNZVmYc+ts8LmDlTpu+dN2d1/uvcpUXsiJ4+H2gPevdwc3Sr2zQZK1Cx7bKuxc
         lgQLgGgryMeWW7+96c1sFDCoQiA1sAq47BO3E9/jPuHT9zAbLiC+IIfs4pDE07RBxLwL
         X6YnioWr1mwzh/Zc9IsVt3MnfrBglgOHYH0J8ruHlON0875Vuf5TnPZmY5k5JaYVN/Q+
         BKWefb3gX6AdrDy398mJuAYwifF1jjXcgzixrxz9dGnk5Y5B9TndMioaXPoA9Mt2608X
         c0425sDYh6XcAgM9xjVlepBD0xzq38n//CEIfuITafmDfGio/Uojqkkngo6fys/AumyQ
         W67Q==
X-Gm-Message-State: AOJu0Yzp4F8Bg7VMQc0JRvdwyKxdGRfvIIvWucklGs0dYh4jt/uCRiyJ
	vbnwdC2M97sxiYCJ/cVrtfA88S9AqCYUwnmYE8X89CaAqNymuslApHy1PE1ad4y/NeZ5kP2I23u
	oE0fKnr18fe4wMn7L7vBc7G3SZL8O3iA=
X-Gm-Gg: ATEYQzxtKwkAVdbvTng0mjHQD0hiJAzcE1ygtWhpPg98UAmsPlZW+tzJr/dQdiMLcMS
	gH2vuxH+30v3e3gcIx/KSd0cgfLTeVPIZfkaSSlreasUy74PnFmYO9e1OTmW62t0xvURwi97JAC
	4TY8LlITggeRn8Y90eWBTSd44iPdAJp+OVeGWPyBa1hGHo5uq5ZJXNc/finfwbTjkP38NdqXaue
	fEkTvqFqwgVr2aMZPj4AyHgnJeMxyI2aWQmibGXIh9DNW4TtU8rFTIDzZrp+5AXsZuQGQ8oMeJx
	Ow7ksa6TfTweUtuisSZVRlweApMr0ig4nB+NpxHVAYFZcka+2raYkkP4pRROtWspKKyebIRFiFD
	GKetPgtmcNtF3B9yUOZdb7CNVLCtTJJZZoHQYPFQ=
X-Received: by 2002:a05:6a00:148d:b0:81f:394a:4897 with SMTP id
 d2e1a72fcca58-82c96085fcdmr56960b3a.44.1774561743007; Thu, 26 Mar 2026
 14:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774410440.git.lucien.xin@gmail.com> <91c6fd0a44eb15a98f945171ead8062badb89a60.1774410440.git.lucien.xin@gmail.com>
 <CADvbK_eXUfnGGQgGc_k-ecCW3-Co1MpGb7UvMgLonPy3HRhyFA@mail.gmail.com> <20260326130740.74b4c92f@kernel.org>
In-Reply-To: <20260326130740.74b4c92f@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 26 Mar 2026 17:48:51 -0400
X-Gm-Features: AQROBzAemDJ3qW1z4xWRURYJNQELd9N64vs5NQq1QodH8yfoSs3wYDdFxRVPhko
Message-ID: <CADvbK_eyNtAfA=JPR5Y4arFLPpkWMs8io=TO83rHAa-JJkhdAA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 06/15] quic: add stream management
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,kernel.org,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 7DF1533C1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 4:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Mar 2026 11:06:26 -0400 Xin Long wrote:
> > The AI report on
> >
> >   https://netdev-ai.bots.linux.dev/ai-review.html?id=3D1624d906-c0b6-4e=
12-a63f-5cbfc51b660e#patch-5
> >
> > is false positive.
> >
> > As the sk_alloc() calls sk_prot_alloc() with __GFP_ZERO, and the stream=
s->head
> > is always initialized to NULL.
>
> Can you also check the google one?
>
> https://sashiko.dev/#/patchset/4019cfba3ffd6f91aee24713d2adc778f858b4c4.1=
774410440.git.lucien.xin@gmail.com

Will do. There are quite a few reports, and it may take me some time
to review them all carefully.

BTW, what's the workflow for the Google AI feedback? should I reply to
each item in this thread like we did with Claude one, or is there a
different workflow?

Thanks.

