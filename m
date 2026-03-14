Return-Path: <netdev+bounces-267721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOC9L5hKtWllywAAu9opvQ
	(envelope-from <netdev+bounces-267721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E028CE60
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD27303429B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC3259CB9;
	Sat, 14 Mar 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmU4kj4d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63135949
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488780; cv=pass; b=Yi6SpNph4cc2J38aKWumbQIjlvpiKDBUZEVlboiqUbO6rnjPDaRa7LcvyRBmGhQAPMFmEA2AmG+eCfQcYSxsl61XSR+5Z/+zoJ7hi3+lQ/c50hGHc0RQ/riROZdeTRN66fB/V6sN5kD6HInSe0HbPXoFQgee/oIZq7QVLy94+KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488780; c=relaxed/simple;
	bh=gq3D6PXSc3/Yhv0+mI+qviFrTLw4Sji7wCBe8LlKJ44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6CXjaHk9TWlKhnCECn8NuntcjP1l8NJuOtotJ+BQthwycM1ST3bolMUIZG6PaJpatJ0/B1Yq1JFtm2yI48ysBN5rO1CzaeBDZEhjpZl9ObqlLH40AvUMtWnb9+adLfqeg2/MyKj0YKkX7GxTn6kIkVzBtTqSuLATzLbkFcU2OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmU4kj4d; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a133cdd4aso39921306d6.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773488777; cv=none;
        d=google.com; s=arc-20240605;
        b=C0zLVxPa4eWccEBMiyvgm8+NGbv5F268vvfCnzQTRQU0h4jAxzZaitBncwOy3957l0
         uT2sHEvWl1wy93yATXIGL8y0qMeOGx8lUbAr1kWtaH1IuRT0OjXLMMZaaal7GVlxuKzh
         OG9j6BbgJUEEqC7iQp9vtH69O/9PnwshwVDxXRXRsHXi8YjPLnXGl9dluEjMtF0zFrSD
         G9pm5OKWy4UdNh/Qi0K/e9kNmM+eSXBBURq2yWV5apE3fNbusJI13Hli6oqTJO3IfhQF
         se19vXQwj5nWYwnXdzzspsbGBdSZ1YyWQyqTwZ2zYbjeb/tTh4e3aUMaXO1fYESwzJYX
         lm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNAG0TVCknUOp8EJm6R+zAf0HUJeizrBaEWTbOMcD0Q=;
        fh=29bbWsD+MbT6OFxfz0zZZCvVLyomyAxdKQ3BPqMrVgw=;
        b=NSCwoQM0I8aIW9dkLhCJekTv01NnRap9KDQd4LIJ3RLXA+xJTv1OA/VewCNUFWLZz+
         WfQW5sldtg/qTo1dWGM59KY/SDmXDS7tFQIVfSOijl24cs6H1qix/DBGtrSFKLzMlhrp
         FZI1bQoZtruUNU0kS6ur0toUWgCEcDaJIh5AByXXSm09Zc08P99Jio1OgjZsPLyP2Pmc
         WwKejmURp4qQjhD9HIOMfT1k2R9SK5scSWnMOZBTfCTbOGiU6v3sWo5O001RIkREefer
         YQ0YauBT91RBuClp2JP3/zmmpBouFOdJpVYCRQTXErmIoftgJ6UeCj6kXgERvwAM0zDb
         0rWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773488777; x=1774093577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNAG0TVCknUOp8EJm6R+zAf0HUJeizrBaEWTbOMcD0Q=;
        b=PmU4kj4dgBVcuchT8iECsI49skO+O9g9tm2IjV4G3OI+s5i4bVPi5q4+dNhsz+ECec
         wxF+MyfMyx5yMeyy5asJWgxlnU3sWR/qcVsPTCRrxWQVbtSyRPT4lc5OvddGmamixLJ4
         /5DfYZX2qGJmBNp9os2TguQTPCU/wl+uW+1/oVNordZmGngTfk2+6TPmYs1nb/wa/lHh
         nw4EGTgnha/emXLPwRf4+YKeLDBozq7UXhIaWPwUPiLDw8HzIUIUOpRUppqRMN5sC6JF
         PwVeNFSyeL8fs/FTUKizRfuKKhOLSh4Gzbcv9bRlXLgLAoBSR4NWLZ/VYdDmaFo8j/OJ
         KS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773488777; x=1774093577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNAG0TVCknUOp8EJm6R+zAf0HUJeizrBaEWTbOMcD0Q=;
        b=Ww8rsF1YtwXNDVngSty1IlF67kZIuzWeL4HIIGY2yPhTY5T/zLg7ltKlTzUa1SPi+j
         cLI4G4si+Zph5Mxmuaxl/FnZAqwyfuNABEQP6bnj5yhf5oFKllhetYbn2IbOxMqeHqmt
         9rSLMEpACNKZhoHBSTmtoz9LBi3NJ71pp5Zw4h5v1yvdURh4zt4VNjMVvz3r+dVrmqbX
         0udo9dTTTmoPxzhWTPsDS7KJnNxvpXZVwPWkVRln4Ixmq4zQ3zNiN2dUMsQo/RZtT0Ng
         gYwrYBkumtLEmj/84Mo0ADHEb/l57aSDanWBK+9TT98z7H8JQLoeuA/s2Pvs2qLLB3Wk
         OyFA==
X-Gm-Message-State: AOJu0Yw7trY+DPvs5i56qiCoa7n7K6H16pEf2OTQ5w7BEqXNj76JVvip
	xKuCBTwpJH/3FRxGq3UucwooA0JQjIhXOzBvpf5MM4x+jor+vuHyIpG9qkZAy4MI7YCd8S94x/5
	a4kh7dea4evw1KAws/wbyMSI1tN1U+glsQVK+oROkFxrouVRpHRVoJ1RMDQU=
X-Gm-Gg: ATEYQzzKVSZZUPGo0hmGGghDhSDj/hsuN6qJSbf/Mm9yFhW/SK+Dk3wY9ddwgm+NHjA
	YWCWVF2HdNkVcDFPfcRhWXKQ3XT6XZGXURLvNvP4GJ4adASSYqNLNUGNLPb4bm0U3qVnzrcOgSg
	lam4UeoE8jby9cm07w82saygkZKNXReKDV7Cb+ZwmAeqrJvXjoPr0BToh+bongqo1EZLzXkCE6y
	/SsK3xo60pdD9vPoANfv4voAt7jR5XWIXI9i2TCQ48t9Fjoabsr0zA2+U6U0AzO1Z52AcfTE+VO
	vapSaZEdRLhHL+oaxw==
X-Received: by 2002:ad4:5cac:0:b0:899:f6bb:24d2 with SMTP id
 6a1803df08f44-89a81f72d46mr98954026d6.33.1773488776492; Sat, 14 Mar 2026
 04:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com> <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev>
In-Reply-To: <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 12:46:04 +0100
X-Gm-Features: AaiRm521bvZXfxzb487srqS3Mv1RVglhDPn3YMJ5qUKLEuFSX8GzsIe5Vgwq75Y
Message-ID: <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267721-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 648E028CE60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:41=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
>
>
> Thanks,
>
> I reproduced the infinite recursion you described with stacked bonds
> (bond1 -> bond0 -> gre0). With an AF_PACKET SOCK_DGRAM socket on bond1
> and an inbound GRE packet, bond_header_parse() recurses endlessly
> because skb->dev always points to bond1.
>
> I can verify this patch, but changing the parse() signature touches
> quite a few places beyond what's in the diff - net/mac802154/iface.c,
> net/phonet/af_phonet.c, drivers/firewire/net.c all have their own
> parse() implementations that need updating, plus eth_header_parse() is
> declared in both etherdevice.h and if_ether.h.
>
> I'm wondering if adding a separate callback (e.g. dev_parse) to
> struct header_ops might be a cleaner approach - dev_parse_header()
> would check for the new callback first and fall back to the existing
> parse(). That way only bond (and team) need to implement it, and all
> other drivers remain untouched. The tradeoff is one extra NULL check
> in the receive path, which should be negligible.

My patch is ready and already running our tests before I submit it.

git show | diffstat -p1
 drivers/firewire/net.c          |    5 +++--
 drivers/net/bonding/bond_main.c |    8 +++++---
 include/linux/etherdevice.h     |    3 ++-
 include/linux/if_ether.h        |    3 ++-
 include/linux/netdevice.h       |    6 ++++--
 net/ethernet/eth.c              |    3 ++-
 net/ipv4/ip_gre.c               |    3 ++-
 net/mac802154/iface.c           |    4 +++-
 net/phonet/af_phonet.c          |    5 ++++-
 9 files changed, 27 insertions(+), 13 deletions(-)

I see no issue with this fix, ->parse() is hardly in a fast path anyway.

Note that ->create() already has a 'struct net_device' pointer.

