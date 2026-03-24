Return-Path: <netdev+bounces-270981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPQSKVRqwmlScwQAu9opvQ
	(envelope-from <netdev+bounces-270981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884B306966
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD93D3033831
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61238238F;
	Tue, 24 Mar 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qehHjXVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0963296BB6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348880; cv=pass; b=aZQFjD2U4l3x2HGlgoVqg//33tUaUV6M7pou4LsMss2hMqVGKK3piYaj0faPifj7y7WpI4Jdu1XZdRoyNMrZI8CD6mhwYzCWvWkmTUz3u6cMhfBDRvuWDAzCOcX1bODZCNoYl76uLQnA6925uQGRq/4HBSUo2trF/Z041i+akmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348880; c=relaxed/simple;
	bh=xp93Eh1ICI7ML4MnMx9y0KJuC5k6BLcFMGK+4ZQVQm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nos/Ke25CLv+pxK6tuTVTATdAMfDW5fgNF9Y8H+n/xoS9MjWJlsM70KIw1PrCoaAfNkHiv2bFIgvPsKOfCLOwQqmprWs2rm6rj4m65gZ1RGwGSFmQyuh+KvysNa7W2vppjc6YIxx14/m7AzXswgy3DhLHqCaOoicob9vDvdbXkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qehHjXVk; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so1696020a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774348878; cv=none;
        d=google.com; s=arc-20240605;
        b=Aj8dQQ8wj+G+11t/Tv586vkpL2yreknWU+reeV+mYcyLDoTAjxh07GMcFLc+sja+Xp
         aFwrRuHc1jLoUuJj9ET827empXc0FvYo1NrskdN2u5KoVZtYzplcuzUQUMFATRfvqvd7
         RnGTUS69RCmense/bvb9EQUrEmfht1Wi0MiQJYdsJXEV/wW/6MB6PVyGIJ/oatXIWC9R
         zZCKy1/Ym50XI6/LAX0UynqWLYQm9mcP31z7aGwrcMRXb5NXjHBw+66lCYddK2ILL01m
         GVDBv5jU/XIk8Zoo/gsOQ2r84aDqZFt1MshjhVZjU0GFhCjmLciQg7GKG4kDRIZGGk/5
         NXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QUZQ3NlXRGUuL7rO5FirwTVcowbf2uTh7HuSZrfvCxo=;
        fh=HEL1uX4Ii5aMjP7NNoULCELp0yKG+PQyokpTGO9e8s4=;
        b=B10hTmC+y9B86yqx+qqEGfdlEbHeA30IQzigYEKoUg67xnTTBPrWHylCKGZRjyVAGr
         AwA1zsAWJFNNPJ2zpiAzNehfyodB2O+RPgKMaocAOSKBrwF5weSaJPd2GjvUMj/nAQZQ
         kbV40HzK3sioZ/IG1+HQAX+8GimSbfJWWskociKtmFjZpFrAhoe3yXQZfTj605W30z7n
         HtWkvpAu6mrV6lY+aXCb8yh/B+ZPYYKpErSlM9xOouUyVsXC7vV5+NP30BN6NXEvmbRf
         44BnnCUBJjIwJuyZA5Mut8JWiHGBspybG1tkDbmVsVStMW50Jj22D91zqmyi6a77sSSB
         ll2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774348878; x=1774953678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QUZQ3NlXRGUuL7rO5FirwTVcowbf2uTh7HuSZrfvCxo=;
        b=qehHjXVkt4rqacf5U2uDIW9GxUa7yyM1CsAaDVxBJDQQNdWbcKXRgxb4oybm0O/hp1
         jebWvmP8z4HhT1Am6ON1dg/KU6DkwwC9sFx3w5f29OcicixtIFNzP4+n57kCISacN5Sd
         njvFBUyzBXrJZlNRmAQG8LESU0L5VYrT256ZJMrEk/pB4HYrqqAXfFhHRmpffdYc96MR
         ou3C2Nh1/4bixHRm4uK8kRVV1YUkD664pXlm6pO+Gvx6FFQ6jhDtE39tYrmH1roP7ZO7
         Y0Kv47pOfJdY9afln9nuHlTjxqStfT/XXRPDiFHEIrKPooN8Yge2x/Hgeah6BbNWDnUA
         N7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348878; x=1774953678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUZQ3NlXRGUuL7rO5FirwTVcowbf2uTh7HuSZrfvCxo=;
        b=GjSvPOyOtxvvKxu7JvCWJSWSLKmt2C2PwLKlRvcP+sCnK9YB0tFryGAsNv2bjjPVbe
         1YW6iLJEosHgm2i3Japj7qtukQuvcb6uu7pGZY17YeTtzrnYea6tyVoZFzN0eQMKTHl1
         qQ4xnIxeZhjcfoCNkZUj15u88rU6DHgSt5KZGY8bcXtp601GuTYHH+r41SuNBC7vGsWc
         42r9brFFLDzOmvphYQeZ5qoDqb03xbeO0Za+UO8JBPXlZKDxTvl9Z9UI1U2xwgG1nsXO
         RrIHlv0pBExU8AEgfgyQgcgI/OFOv6F7VWFh86S89CsBGwzGSTfcRzm2EmhRCdDPy39F
         bwmg==
X-Forwarded-Encrypted: i=1; AJvYcCU+1OtXL+1uzUS9NkWGzI0rh7oBKH1D6srsIV9kZaIo0mZsvZeCCRNNRbjF5TKQamZMwnUIMlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqY+7/lDTlrHT9r/SJHd6McA1oFRqNJhA6/Kt/M5E30EW/Oi7
	lvI2r5IZOY76lVODey1ZypTQ8AdGWsXm0e2R3mpcuHxwnRlUw+a/JcF+9O1wAkK9leCOJ3Ef7YE
	be9MyGJNop09vah9/mRUsS00sWQSX05w=
X-Gm-Gg: ATEYQzxq8YH9A8nwpGU8ktkYwnzDuGE05xQ0piMHAfiSQLR5nqCBw9xJKM+rlyhUFH6
	7yIfdjeY94VWa7hft2WX0xDBcBWzsap11pCdHuwnUM/oCW7uEMt+Koo/LI1F7zofG03NDkXWukf
	P+K8X2f1SGHti4x1uyD4xwa5NG2XoETOdK3MvLnY63lvXcEBnwtJ8HcC0D1+7Cc6cD4oNCdkyrq
	O7XdOKk2jzJdzXA7hAKOPmfyjk+jj1iQBALqYbXv/mPhj8Dtvh4rGC8Z8iJ6t5Mg4ryR0UZ2idI
	w1ycEnPpBAfZ3q3f5xtVH5fPHwIhekYrEWQw4V0l501J3kQ+6vY=
X-Received: by 2002:a17:907:d58e:b0:b97:aba7:1969 with SMTP id
 a640c23a62f3a-b982f3cbc95mr1051584066b.45.1774348877549; Tue, 24 Mar 2026
 03:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com> <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com> <willemdebruijn.kernel.2497131610e6a@gmail.com>
 <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
 <willemdebruijn.kernel.5c56580eb49@gmail.com> <CAMa1Pe5XGeyk4rf7rX+4FjwPzUhxdKEw5Qsi2GwkeOMr6fw6Jg@mail.gmail.com>
 <willemdebruijn.kernel.35a7766bac9d6@gmail.com>
In-Reply-To: <willemdebruijn.kernel.35a7766bac9d6@gmail.com>
From: Guoyu Su <yss2813483011xxl@gmail.com>
Date: Tue, 24 Mar 2026 18:40:46 +0800
X-Gm-Features: AQROBzDs4gogp6j73rU5HK9XOl2G8NIEZm7k_y_R2oiqnjdRJPGiW5Zva0O6IJg
Message-ID: <CAMa1Pe7Pn5+TTnsnX3yQD02sf1JiuYfnxt3==jCSeWB44rJs+w@mail.gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270981-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4884B306966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Perhaps you're running a different repro from the one I used. Which is
> the C repro from the run at commit ca4ee40bf13d.

I reran with the exact ReproC from that run:
https://syzkaller.appspot.com/text?tag=ReproC&x=10e3fe5a580000
(commit ca4ee40bf13d), rebuilt locally, and reran.

> I see that the virtio_net_hdr has hdr_len 106 and csum_start 88.
> Those are fine. Same for your repro?

Yes, same in my run as well:
vnet_hlen=106, vnet_csum_start=88 (first 20 dumps are consistent).

> The question is how skb->network_header can be greater than
> skb->transport_header right after virtio_net_hdr_to_skb.

From my instrumentation on the same skb in packet_snd():
- packet_parse_headers() sets netoff from device L2 layout:
  hard_hlen=172 on ip6gretap0, so netoff=172.
- then virtio NEEDS_CSUM path sets transoff from csum_start:
  transoff=88 (p_off=108).

So for the same skb I consistently see:
- snd_pre_parse / snd_post_parse: headlen=172, netoff=172
- virtio_needs_csum: start=88, needed=108, p_off=108, transoff=88
- gso_dodgy: nhoff=172, headlen=172, netoff=172, transoff=88

I agree early sanity/drop in virtio_net_hdr_to_skb() is preferable if we can
make the check precise. The current patch is only to make gso_features_check()
safe for DODGY packets in the current path.

For reference, skb_dump metadata on that same skb shows:
headroom=4, mac=(4,172), trans=92, net=(176,-84), headlen=172.

