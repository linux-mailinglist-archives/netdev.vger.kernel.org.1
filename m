Return-Path: <netdev+bounces-272592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MLND4iXxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D734643A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D7D0301DC34
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647343F7ABC;
	Fri, 27 Mar 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn0zYwQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F03F54BC
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622594; cv=pass; b=OFmhPmOqpQxLmeb/5UiDO5hqwbM0hUPVIFKBER7/VeG5OZ0stQJIQx8ORh/ug+M1DMCDYYFF5ytibb+zbRa5mWKpBDDnTkQVrSBJrslvkuR6r0kQKSRue3wFBGPtlCLu1Z7UKC9DDJP22YiewY5Of0Dw+CfQT7wDUZIL99jSR/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622594; c=relaxed/simple;
	bh=VoXmf57WJpwyR3+/FyywPtdgcsZegXDOU57WERuaduQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxnuZxkmKxC7u3Z7yakLchbC33pcXBcOZPWOy6uiqfOCiTR2yvcZnt+J5tTEC6kTFFL3i7MyP9Ch/5U406z+VJ8MkrlLnKNJ/JL+IUgvV7kwfO+D9WbUWf11I68cgkoJnI+VHzFwQJhqaeKNDM48Le7kyCpr4FFQruAIZloKncE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn0zYwQ2; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ab3e26cceso19020927b3.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774622591; cv=none;
        d=google.com; s=arc-20240605;
        b=cHFvD7jBBb+h8lNsZKdTiZDlwRWSnut34uCCzv/2thjclHkwk8/QQTe+l1KYAGjwRK
         H7Xe5Ioj6vFAgSdwmtSh6QO9Y1waR0pRzZQL6SGHWyaxf1xs6ow5NUd4OY4ypOLXEnSW
         d3aqieoPYgrcVE2B5uhIxcyaO1kA6yTspLs8XTGlJq5yZEkyWkCsT9elfn8cOITI7Y0M
         cMBFe43nyczXJzFNkPsIIVtDBUGlOtJHjz91zc9uTCxleLv3ZpEHBtyvLUO22MyecvTS
         DIyIy5wXFSE/sfo10RerbkQEYCb168CXhi1xfYrntZAvW5LsMAJEaNI50nGEMrsneHFM
         VRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VoXmf57WJpwyR3+/FyywPtdgcsZegXDOU57WERuaduQ=;
        fh=WXNUSQ382lxnDqWfENlqjPjtQfxNdlP9CqRi3rY+wt4=;
        b=GFOzarFjkff5nf1dS9XcunHS/4KjtBlEwIRHk9eTA09mNZL2T7gXsbhVMspmjyg3kt
         VKy9NbxCmGgjUxrpDlVn5xI6rVPyqLuSN6gvlVrCl0nKMhiEpwql9Zof7Ch5VnvIs/R5
         ft5Fmm64fHO0nPJrMy/gVE/zydxX/fxMEmtEN/xvbnYG183XtbV6cwOxt0zLiiDdFdui
         Cji+abdAOeug4XvkkPNO2kBcGoifICaSOMYwj857rgSBBW8f8Sfs37ZFdSkbWLmBnl5r
         x+6pt+sMS/FoC/OmxiyCbYYNPVU2pQAoEY8Hf+fHSufY0E+u5fvMJJB3zuyZvTf+Bxrm
         iVxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622591; x=1775227391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoXmf57WJpwyR3+/FyywPtdgcsZegXDOU57WERuaduQ=;
        b=gn0zYwQ2528vxW5WwddSueWefFTCAXhJD3A36QF5QvF9E2bb7Fytf/J8Mx3Z4TR2Lr
         YW2MEaAWECTkB9S02m2tdUPZEg8bAXw2agSY+K6cjW5AbuMbkPjI+ad1uUHaZZFarWGY
         RHvsON7s7zVAcLTNJXrOiBLPyRnQfnbk32KcIzBcmgrolKjD+h7WevlnLOQ7NMITgJbO
         jo0c8VcvGuwtB+0FcWQPc91Cr6ZgYU5DvujI/r/osDCJPwPpBC7gX3pM7jEKkjuDMTZ5
         ztCvQaoQV+xXCsQNRxFxmZKHX8pRrT6q09o5qON1mPQywiElaivhOnOCUEnWWK//mlVy
         ebww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622591; x=1775227391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoXmf57WJpwyR3+/FyywPtdgcsZegXDOU57WERuaduQ=;
        b=tP1fb9pIyd3fhabFHKImwSUtJlXDEqU3es70hw1FdLpuboaW+Yz6YH3PKUoIReSdCB
         YZOvkkm2jTekb3tF6FoeL+fh0SEmrpcX7NrIdahBZs4AqhzJ39CVnn+SgAqhs8zhRl5T
         9tD6VDiwRvp+pl0LCWL7RAkMT8fhPD4Db5prjsMIOucfiv6iJabG9L55bwg64m8ENW56
         +njXwtWt/L66Chq6i6V06DQW4jJh8E0fF8cWiOQ54Beew05bzni9c9SxqHp/Jef6y5q9
         wE/SO68ijOWEoBDQNfbzx0wFdCtrKwTK47qi83AKW3i5+75BsIOuer4UD6TcfUNgwk+k
         i0bg==
X-Forwarded-Encrypted: i=1; AJvYcCXopp1s0UfpxV0dt1RyfBQgIa+WROsXV+3YLO2g6qT2VVifZCHrO/Fn9bfCkgq2smCpJZSHMcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8C4XV9tGOYyyfLRcLFn98VY4vZe4PgEcNj87HOaVDoeqRKKO9
	MUR8d8duG8Yd+Cuxt5hKMATHBMInkbFzMyZsCfUrRcqxMokBbp1aElWjqAfc/sophbYqkm7uzP/
	InMi37bDFX64+BK1M69O09woPdgqo1jg=
X-Gm-Gg: ATEYQzxiPV3l349MMLM7dV2WRkPbs3nl7RmoNjyKMhaW/Clg4Gs+QzKTb6PTWrE96qa
	5epDnp3rTIlGsEkwPj8hQoy/51TzziywFvVDTBxIZbea3yHSHxqNFPWBHqAvSGu9mZGz8uJmloE
	2cjGQXlwQJOjHZ5uW9kn8WYtGge/+1aDV9Y88LUVZFmzSHsa/0Wt2QTXikHZSfw8UWaYqNTiZLq
	/ObqJ3PPxNb0fLra5f2zwZ0LCBxDtz8k3ILsJsa68TwE92tB04LI3vM215ujmScVl+FmDN2fHYA
	4dVI6HhSdMdMYqOsepp106+5byY6KXlWaJXH
X-Received: by 2002:a05:690c:30a:b0:799:266:83e0 with SMTP id
 00721157ae682-79bde0a99e7mr26912277b3.34.1774622591479; Fri, 27 Mar 2026
 07:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
 <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com>
 <CADvbK_f3LwEt+-BG-1Pcr4jMn6Jxry+0p-Fu_s0C6Px+F_NHCA@mail.gmail.com>
 <CALW65javKc9H1zQ4m5cb0qPfXix+bWM9LcVZ+uQN5BdgdTQ=gQ@mail.gmail.com> <CADvbK_fug3vckLkfufLTtqTEKzywRUw8C_dzfW032_cb6vLpZg@mail.gmail.com>
In-Reply-To: <CADvbK_fug3vckLkfufLTtqTEKzywRUw8C_dzfW032_cb6vLpZg@mail.gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 27 Mar 2026 22:42:59 +0800
X-Gm-Features: AQROBzCTVnUCnEkObm9eV9Wpx-1Um5gzBGefD-FTNsN1J9iBMTj2-Zz0FzfAi3U
Message-ID: <CALW65jYQt9-EQ0tKkgPRGMdf4Ra2oq4BT4XkCPu0zaRH=rzviQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272592-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB4D734643A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Xin Long,

On Fri, Mar 27, 2026 at 9:23=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Thu, Mar 26, 2026 at 9:49=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> =
wrote:
> >
> > In my v6 patch, I set phdr->length to 0xFFFF. Is that okay?
> >
> > https://lore.kernel.org/netdev/20260326081127.61229-1-dqfext@gmail.com/
>
> I think you need to check how the PPPoE stack handles this value. If
> it recalculates the actual length using skb->len when phdr->length =3D=3D
> 0xFFFF, then this approach might be fine.
>
> Also, how does the PPPoE stack distinguish between 0xFFFF being the
> actual payload length versus it being used as a marker to indicate a
> jumbo packet (similar to BIG TCP)?

In the receive function 'pppoe_rcv()': if a skb's actual payload
length is less than phdr->length, it will be dropped; if greater than
phdr->length, it will be trimmed to match phdr->length. After that,
the phdr is popped and the skb is passed to the generic PPP layer.
There is also a fastpath in Netfilter flowtable for IPv4/IPv6 that
bypasses pppoe_rcv(): it does not check phdr->length at all, and only
relies on the length field in the network header.

In the v2 version of this patch, phdr->length is not updated in
gro_complete(), so an additional check 'skb_is_gso()' is added to the
function to avoid trimming a GRO skb. Then Richard Gobert suggested
that the length field needs to be updated, and if the updated field
matches the actual length, the 'skb_is_gso()' is not necessary, but
only if the length fits in the u16 field.

