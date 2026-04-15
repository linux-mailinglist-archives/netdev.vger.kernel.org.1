Return-Path: <netdev+bounces-278757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFOWL1+B32mcUQAAu9opvQ
	(envelope-from <netdev+bounces-278757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD465404282
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63D193023C9F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7434D3B5;
	Wed, 15 Apr 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="erud3izN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB03264C8
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255297; cv=pass; b=klSDw4ooVL8jyRJGM5gy/yg3gWstni2vZGyZ/04hBZr7BcdHAS5vk35CNQVEFTA+WrMLIJWeuwEk/tHCeAGKwIWS52FCRqRVaifyAdMqwHtP90fmuQcaK1xaCXuFGbwnfByUbX82YoEg0/dQweW1oJX0e9d87qdljvGTzjz7wi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255297; c=relaxed/simple;
	bh=/TlkS2tZg2hU7/1WPLi72UV6JdSQUV7tv1q6oKcl6EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BARZRX/nubwfAD3KtO69oyxIv05oVFdkSG4d65AQp0geLjaQf3tuRdTPJlHv3Yyl5tGo/Tb68Xbz3QPnFzmnLV2gfVahmksL8lUbbrJC1dNft8tzSQku65nkpGvG8yxznijKhAPs2sK4dANF/3/SPn/g4LpO974zKDs+WvG2nl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=erud3izN; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-126ea4b77adso16040786c88.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776255296; cv=none;
        d=google.com; s=arc-20240605;
        b=Dn7AjmxXeri0UawiDp1fecIRUEVugL59R3TqloL4spJihHK/BVtV63us0IhnD6wRDE
         DzsoLY9ZmxJ5Ha9xTza28jsh2KcOBQRDKfbmyaVjhcSTY0/TBIsUpj16jyR2ALYbGxhz
         sAI7y2d3lasesGnD+g4Ve4Pc26TiiKPh3p/hkF/FGt329zgY2a/Yq6kjbeYzELYhMVyH
         i5Ox4lI5/Pt/n1VsTQnSTA5CojgnCHw4NsTOzYc+Miwxdp3kdajd//m46SKdqY6Xap3w
         oBZCOf8D4d5xxzWMi8odiG/DeSfwTFE8AzbZq4rwEa9iXIslaPjSUBDBlS9wyoF0C739
         WEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/TlkS2tZg2hU7/1WPLi72UV6JdSQUV7tv1q6oKcl6EI=;
        fh=QywyOJ7YCuSeehVZl5NlXnuekSJXo3wM4Fijj8yMdYs=;
        b=Y8DWDmIRqYZWI/b3MJRrtx+ormSpiga5HriQJHTaHrlx0WnkNEOg+wzjRHXgPceoWH
         dpUhxS9ms9kGfVUXkzFCKowShChAGWM7v3IX4T0YHvNwlUR9ZxK3NBMu4l/RW1IO8gKk
         dtqKXP5WNkE7XUm3xzNsqMYzpu6YFlPOkdAqzDCSD45kaMMK1cs8QXZEVAooivtzQR4C
         6OzdMvf3PnGVyDPDpIYdlLt6YBaAb3IZQydN7YYzBybxuPk00Md9NhlggKHmH50k204W
         naokC6nPzs6eECXFCbffXzGms9s2W1j/KBPIsTHJiDJVWiOe3VotT5SMz1HUivLtuvuf
         CxWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1776255296; x=1776860096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TlkS2tZg2hU7/1WPLi72UV6JdSQUV7tv1q6oKcl6EI=;
        b=erud3izNnV0ejqvv5SHQ69lohLkax+CryTyGho/hDNxi7xSn5y0aO6CVZyefJBCUcw
         QsEnkYxYSI9i0doATKX2u1AGYkhnQR9RvB1AHEiOTxQs2EE0rAwaQqz/tHeuH8GaqMfV
         Q3nWHG6dZphUY4czl5eRwk3vbeVNoys2biG9n79qzUWJ94kpBFVSLGOtY15V6AMW38NW
         h/HrxO3lmEjVrL1tBRWztj/81SYmOjY8bnU3QoR4CDOQH7C5DofTdGM2c4qhoxe4wRPS
         FN0873I8gvsIt9VMx/nprgcHf3BkM6ECVlYKOM6ElJi/mIzVtfvRzR5bzvYKh6aivDqc
         QO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776255296; x=1776860096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TlkS2tZg2hU7/1WPLi72UV6JdSQUV7tv1q6oKcl6EI=;
        b=S0VWrJuMYP6QG3KAilFLK670bU20LLvFU9sLlezvQQTbkv/DiBGhxW+hXhSxsjyQGI
         YZY8Nua9QJCrJlV0ncFc5bpOdtmHOCqovtoW1/lVPWEARS/TVe3eF2N4fjOCBGfea64e
         RjTZ3cnf37Thj9OL86LYXq7XZXaAvmwvwclOM24g3tTpq9qB9iHytVRl9M8IvJlEGBhu
         j3aG3Cqet1boQMBg1oHUcEWAsYBb5feyaaNas8QVkBHfqyaliUXpHCS8niP0ykEIgmEE
         1NI3VLYt8aoPEG4qkKZQEAxP51nV1RHjTD6oiPpOoPHDBRZJ/yNDFhQ7RfwsTlSLqqe1
         Wcvg==
X-Forwarded-Encrypted: i=1; AFNElJ/adM4rwFgfzxiouEIiWFZ4d6kM8FKHObLcKbHftKaYLKXO8725DfO3SkSR/JXo+QyDC1GeCyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMz4UKpJ+FEA/2jx0mItG+ZKYlilViYIzKlbE21kgLj4rS4/EP
	ShWEHhNAFVusATnESW1KqZKAip3C02bGelNjEtzuWmusVx8PkdnI0F82vnSHBos8RbEch7/G2X7
	p8pgpxYo1cmf7baGLL7osd9+XjdkGDqy4kCLb/j1seg==
X-Gm-Gg: AeBDiesg1jRxtuDTbpcgm0pCCUko1ZOj+nxPMn/o1b6kEUeOGvEaV+S7kwmq6OrgJpf
	cJz3qgrviViIa93EHgGot4eRkolBNLUfk+Zq8Nm75EAJHPt2MY3Est6Ik8C8Omfgs6gwM4PaXMo
	51uWzW5LsnDFOUT7SB+tKgqsfOFAmD4E7TkqZSERAI6W+lRkvBAgl7XroWEaItGWFF5O6yk9NWb
	m8tQ0IlrfnX7DeAIqTDqDV/F6Ks+rRRRnPoTEMUtlbWcnuOkffWAx27VnYgwH7paxcnLPaSlVQT
	ATAmwSja0u94NH8GPwL9ZmaPZ4sku4StQRmgke6QXhoXhOWZWNZym7UNq98vueUBHlFUMGRHUbw
	YBRU=
X-Received: by 2002:a05:7022:6896:b0:124:9fd8:4ba9 with SMTP id
 a92af1059eb24-12c34e8a959mr12554468c88.12.1776255295680; Wed, 15 Apr 2026
 05:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410150943.993350-1-alice.kernel@fastmail.im> <20260413155552.5cd00bc0@kernel.org>
In-Reply-To: <20260413155552.5cd00bc0@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Wed, 15 Apr 2026 15:14:39 +0300
X-Gm-Features: AQROBzC3iIhaOgf7wVpZjFjeu37dVss1KM-cSS2ss3EXLEFVham6WuFN-4mttMo
Message-ID: <CAD0BsJU_Q6O6MpOMvD7dv6tPYsB8w8SFc-=2mEGpVJtUJW2u-A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/12] BIG TCP for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278757-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:dkim]
X-Rspamd-Queue-Id: BD465404282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 at 01:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 10 Apr 2026 18:09:31 +0300 Alice Mikityanska wrote:
> > This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> > support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> > IPv6 BIG TCP doesn't require stripping the HBH in all various
> > combinations in tunneled traffic, adding BIG TCP becomes feasible.
>
> No longer applies, sorry :(

That's a pity :(. I see that the only conflict is because udplite
parts have been removed from net/netfilter/nf_conntrack_proto_udp.c,
so I just need to drop my change that touches udplite.

> We'll have to revisit after the merge window.

OK, I'll resubmit after the merge window. I'd appreciate it if I can
still collect review comments in the meanwhile.

> --
> pw-bot: cr

