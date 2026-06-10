Return-Path: <netdev+bounces-297538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TNVSIyEkKWqdRQMAu9opvQ
	(envelope-from <netdev+bounces-297538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FBC6675B4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nTIV8HHN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297538-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297538-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527C2302BDD6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1339A06A;
	Wed, 10 Jun 2026 08:38:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F23AEF58
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:38:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080701; cv=pass; b=VX+UkLZ4v12yemiSMm6n/rTHXhzuoB+6kNJ9DHhbWfgmDgTIhxhDPReUPbd1KTeELIWEVYhOLOjjW88OFXIi5daPoKLW926R7NDd5L3aYGhsCvLwhn02g7Xu5mPEE+TGpNGN0TSwBvD8naIZQdhCCY0G+5R2YPz84rS16JEaQp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080701; c=relaxed/simple;
	bh=NRlvWbJzwF/mAJk4SP+2M4uTU6SrRN6qN/Y4wVSqKs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eer9accNH8loogs3FDaIADTIF+hKndECvq1/soVaf1wON52jrH/YXyDEqpMf5IfsTQMSxA504peKMJti+JwBIAQg2qT7rXwD7uV94WUOYDKSGPhUFdDPijOMxYBun96LKxLxDZhjrjlB0OBkA89xLtdgGBZ01Okw+/pItXRxwKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTIV8HHN; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so273581cf.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781080698; cv=none;
        d=google.com; s=arc-20240605;
        b=FiP/PFI2Hnm8zxfmJ7NQFUZ3pHdXsAmP1U13nE/WWX+Ia4aLNWcJaqZk1n1N7yzsKY
         IjgSWAORG05raSd3LR6WD8P0NfXCDNE3nYFCBxQuXhF1KJe1nbMJSB0jOjqkz58QGyBf
         BxvjgMC/bAOKV6I5jLYy5TQ3vR7GgXo7HL/0ce1ghowytUozk55SfYE+FLXD8rSVkX9L
         eab7DoGDtO7T0ki+anM+Znwa3uXdUBhYbcL/lkJt844c8QfvJPcETVErKrEWH/Y9WIZJ
         +tqm2DBHagoyrmQNvKV9hFNEKOkjYv+JrqGMFAyoXgGrZR0VyZvqg7vO8XoMTqwRjtsK
         JZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRlvWbJzwF/mAJk4SP+2M4uTU6SrRN6qN/Y4wVSqKs0=;
        fh=gGvU+5sD5/2Si/vYmH3x8ugk8nEGI3jE8noasAkn3+s=;
        b=dLrXuaQQAvrbVwhP0HU8oJUFjqkIqbcgq7OyxoPhbOIAXpHDGT5LgEKzGaZW3b6lu3
         FrXAithYxcOGnX9GGMx3l/PqvfVwi0MXPVSTCO/P2wZA9jWdku/U34HazOe7aFEJsyMZ
         rG2clxT6prNVis7tIObsOfwsbWGGIX/ZpKnclZ0OWErryWSEwTCS/PAiMANv5z1EH84m
         rALqZysnmI+k+2EC5aZ0SgB7oHrsX5EVmKGXjK4yIxQh3/ep8VSKQ9KktoOl9sSqF63f
         jkPgZc02E5KKB4G+BkdXp4tAOUYbYBHE6XJVv+u9I+wsiqo/Tb+BIgQ/yzYuhWCc/g+Z
         dpRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781080698; x=1781685498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRlvWbJzwF/mAJk4SP+2M4uTU6SrRN6qN/Y4wVSqKs0=;
        b=nTIV8HHNcC7dyWrbGaCOJ6FwQgWwKgiETg9MkysV2ZPJJuzY3VJCNAJQ6vXFQ9bDHd
         ml5D2aIAldPYfqUsms2D0sVyv0UeiTTgGpxs6bhLGhCh9I7vw0csDADxbrSqqKGUi/Lj
         yZrDMzp39IjmqbAn3dYaSsIe+WwjBYFyX/t41/5vLenSJvP0j7ry79inCOYCqXo0OsxW
         weGsq8X7FD25Dk7/K0gNl4VJrpiTscjJxo3goReo1syiiGfeISMY/Mt3ZwkWevGodfh4
         TFeeNUoLrxNibdVlg5l+ViT2IJLK8VJL+iWCc1dyyjlHyt6xzcTM9hGrFVmmWQOMECGY
         Xu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080698; x=1781685498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRlvWbJzwF/mAJk4SP+2M4uTU6SrRN6qN/Y4wVSqKs0=;
        b=FQDa4b7bx9j3GAmcA1ENEC8Dvbjuo1tezA/SImOCT9L/9EK8yfQEQpbI+Fynn52737
         P8pLu0zHqJTjRYDD8+bHJnNdyM7F7rWy63qN04UVD+n5aM1V8gbQXvXLCqMWSwSL826z
         gKbFpelL0Ys2iy4+krkhIlYX9VZErFK/4K/8U/QrredI4JxPS2wTAW0t0oWG7hXI1yWU
         eFBrXWQXHCxjvXvIyuZJAaY+8dQWkeMsXQsENXHKIzCcrJMHwfQvrAGI5pLqygYQnJGN
         IUXT5y0alGd1KxbbukI7kmkeEWb0N18r6JAeXnvGFR3o4uymtXp9y2TFQ9X5RNESXBHw
         02wA==
X-Forwarded-Encrypted: i=1; AFNElJ9Euk/r7LdWqhwl4YE6yKyI4Zvl7ojTdhworhIl15zXjXkZT3ClNrTDFJXIlq9RyfJaQ0oBdJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9t7XmP0HI8B5C4R4r2m/b+N45ih+kVqxD9KQBBYXfV7KMJ6JR
	R/nMaonBIgnK7+5PqneuyFSMsWeR1BSBgPWiNHU76L5QaMGdKqqyMaeLQCqSQvdLr7EQn4Vllqs
	vUbmFfmqvyi5em9nQD3gCZgtzi3Y8SW0mkeRuTc2jzzFHtmuFz4TZdWzLa/8=
X-Gm-Gg: Acq92OG05O7wn27JRKXbpNL4CE7jUCivPXzRRf8G3yE3b9lA2/O1mZ/qhnq5kCfDwli
	GGo79MO5HeYwg2cX5woFEn7VYqBJiYCdIMWSr+jkmd1SJafuiF8oGzIglDQ8TrsjeTs8b5TO69L
	U+DZjlEYiTr5EpWLXwEi5kfxSgmU1LK5ID7wos1tWivt/e6L9Y1XqPhM78RssVUkMJXlB1lhc7w
	YsKo4uJMTHv11N+YgBvlWrdxZ0+gBNWJQ70wUFS2DE0iAFDam2uIAMhxpNKvXnUvYuZvJbAkSPe
	FUfy+Moa3Avw/xcnvizT2l2GV0KUl0Muj8VH2G4Jg/PCSw505NYj3hn28MK9OkwZoy5p4lMQlY6
	F5/so
X-Received: by 2002:a05:622a:791a:10b0:50f:af60:3496 with SMTP id
 d75a77b69052e-51797ffc93amr40960591cf.1.1781080697486; Wed, 10 Jun 2026
 01:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609122646.2297540-1-yuyanghuang@google.com> <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com>
In-Reply-To: <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 10 Jun 2026 17:37:40 +0900
X-Gm-Features: AVVi8CcahRnBxTtyxrrYUhGPuHOoF3ozHy8x2BkH-nK4Cm6_s9U_wZryUWK1m7k
Message-ID: <CADXeF1FaYn2sDyM3Kfic5eyP2oQO9uQE_rFbwwRZFrOqyWSJcQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nicolas.dichtel@6wind.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6wind.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4FBC6675B4

On Wed, Jun 10, 2026 at 4:50=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 09/06/2026 =C3=A0 14:26, Yuyang Huang a =C3=A9crit :
> > When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates thr=
ough
> > the multicast list and calls ip_ma_put() on each membership, scheduling
> > them for RCU reclamation. However, they are not unlinked from the devic=
e's
> > multicast hash table (mc_hash).
> >
> > Since the device remains published in dev->ip_ptr until after
> > ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_has=
h
> > can still locate and access the multicast group after its refcount is
> > decremented. If the RCU callback runs and frees the group while a reade=
r is
> > accessing it, a use-after-free occurs.
> >
> > Fix this by unlinking the multicast group from mc_hash using
> > ip_mc_hash_remove() before scheduling it for reclamation.
> >
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> A 'Fixes' tag may be useful for backports.

Thanks for the suggestion. Per discussion in the following thread, we
don't need to add the Fixes tag for a trivial fix.

https://lore.kernel.org/netdev/20260604101728.GA771160@shredder/

