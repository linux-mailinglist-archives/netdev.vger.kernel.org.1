Return-Path: <netdev+bounces-291226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1n2uJ36pE2p+EgcAu9opvQ
	(envelope-from <netdev+bounces-291226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2C5C5403
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17BA63007676
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD2425DB0D;
	Mon, 25 May 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo3hxI7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DF256C8B
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673467; cv=pass; b=KDmwYPc/3x+fndG8bVXzx8+vdldhYTtOeU1cE08BmXHhzRQHCGZqZ2+9EHiAA7Ye2rdrrGGjLC90Z+fw66HfWmdlBFV8vpfzXpE7T4avnlaSvZfHPgvsEIGQnjq8yxfC9n+REXFEkir6UsHemoB+6w00pe4axIawSgsbGIDg96g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673467; c=relaxed/simple;
	bh=ncKtSpXu7pCHV+FYMgLpGNtvZ4E7dz2d54nRBRZMz6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9QSkc39pfmew/1cO8th8jW8asTvbRhzdt9SA37amJB6R/E9WuAxUTOuVcNVy3qLD+ITGfIGxzGSggmmJMnc65PS/6wZOhm2MgsRvdhDsqsWjZDODcyOlAdrxZC75HZThHstSHp1iNYCRF1Dwalj7O3BQwxfelLgsdd3y5E0AJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qo3hxI7k; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so19421966a12.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 18:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779673465; cv=none;
        d=google.com; s=arc-20240605;
        b=c8ivGnd1slDV8eXDOI3I9GBsVmfANfWqmo4T6oDoUMwIkvTwnZQCogiNhPjP462CAW
         /JPDAyZzhn1yE581keXOSnu/EndKaG3sbKRpRlB46GacRi9dQzBXSeQ6ijtoH2v1jEEP
         F+mrA6dvEy/Q6125w0e1/z6jZcz/iqhs7n0ErxCjKx+rlpqBEnXhJIbwGZaMZGnvsoSZ
         8xioE37+8ZLTVQnIJI99oKUuMpAZZiTQQAvXMxAWMGnrB50SqyYzAXnLrh4KHHTPSqZz
         AI4uACwWya4fIxESt/izmG2R7zrFR4TWYjC2t98s+P481XGwbsMR5iMIuXRSZuStbWHI
         Kspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ncKtSpXu7pCHV+FYMgLpGNtvZ4E7dz2d54nRBRZMz6I=;
        fh=rDyDgdGjpxvR8jsin7HfxIxqy0XZ/4dYUYWhuAWlfio=;
        b=AaYLllV86tzycC9r9wZHNlnBv6tPJ/QVQ/fFnIznWvbfmM6NVEKyf6a49jB7OuHnVM
         EXFgiiyj8ouDJ8bZDr56uY1+6jemj5DOjh6P+vZyZ45VKpMUPXBrzpVXuLfoVb70hykc
         Bz+U8zi/7sIulpPw4QbB+cevyYtGJKHqPzXQ8fce4kmTXlCmU9uV8LaYGMxP6KcjMh1S
         UcbGxNlpKhTl1imZtCna3NqC+2P5bjWukaCRT4QRhOt8ijgqIuWV0K9+UqekkoziLti2
         bO90GO8oAAtGfIgSbsDKKLMhE14m5W6RgJuqLjsq9HnHy2TsmPDaHLUAEAcUuPtjEQCd
         jdhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779673465; x=1780278265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncKtSpXu7pCHV+FYMgLpGNtvZ4E7dz2d54nRBRZMz6I=;
        b=qo3hxI7kIAHe5a62AcbYg8rwNyPCiVI4Gn0xso13TrfXAIrUEKseZRaUOK7lDCehn8
         QYr5UGYILoUUzuOQF4lelENurTL77H+qTIXsvK07mJovCYPXMprYhqt36ugQx94ZWsAV
         yd0c4iQyS5gxuy/EZXEk3rpsB41i6vUF8MgdSJEMCpfu4qgcfLZvREQ+jZyBom79fZHN
         EUCNWwb3viaAvzARBsXwMgQMumYSG0F3zibzirFy5Uqz8XmdUarswnjoZtQY79SJlnwa
         EZiShx9NpACCPMMLrjX+Y/NGn+KR183vDSnJLIiyDniv4hm5fYZIj6VgX/mbpUmCKhnH
         YE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673465; x=1780278265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncKtSpXu7pCHV+FYMgLpGNtvZ4E7dz2d54nRBRZMz6I=;
        b=ZsNLXaBrTzqm1eFs8i9ojIW6jbMDS7O4+Bkqqda4o9jfRXS1H46Re2rUXlI+Z9GsU+
         zsDXGknxASnR9HD6hNO4QVdFZ/D+MwkY6D3v3jnTCllmX3MJ7+y210ugfXluiLvWIExw
         zRi7hvUN2EZfqg82FEsx8wXc4UTWBSLZFzou8unqsdLu6uhcUlftfxslZyvxUq06RKDK
         1eM5BDIX3wxbBA2WJqb+vY4ny+IVbgwA86b41S9s3/ola4/m2/b+74RDPIAJUOk6MU6a
         KdQsYveEjuHSiJQNsCm9tD8AbZtwaRLY+M+bUX1ghMMI+d9qjSxv66g+gI+f9GGj+0ld
         ss2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DeX73LZObSNTi113rptNcXjZ5Z5KousQdrC3U9fqDzNursQOeNK5uRssG8vp6XLJLU3MOCzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSDV0EYabZ2rOflr36H78KEwP8XiWZopedIA8J8TqkEj4iE2d
	cejf/surJkVA/cmB4UT+M3wTbqjlt4qWxOfri3BKr8RHSkWFsIf/+wQXHczqZT4ZPU28cqqscam
	OXnB+d5SOQRAiJIsqbIYu2lb2wmcPj18=
X-Gm-Gg: Acq92OFNzFdsCc4sPa8WnpetKrfYMsaHFoXFb4IGToY125ofuETBXNxNdDI+Sj/fsQB
	33Ogo7/vmG6yZARkPKasU1zTRPiIGp089XZgc8+qYc0VmqJrRsMcTN1Ld27AQgCcbex4MKofJ8R
	VTorCXcJKNTDhxYf/UrL0JE49UWI/6SLHkNgBWYCJ2H7Lf7owoEXXFMOIz6vjO7PGRhx22Y8kMv
	z2gZk4EXSVCw7rnZo51ul6lYVjK7kLEPEHURT+V9zZV/CeIWemDphqf/W8u/59EBr2dr86J3vqZ
	cNbDl2N7Q87eSylE+HUARDTmcjsjyM2isnu8C0ciAw==
X-Received: by 2002:a05:6402:370a:b0:670:6ff3:6d23 with SMTP id
 4fb4d7f45d1cf-6889c431257mr6615752a12.7.1779673464584; Sun, 24 May 2026
 18:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
 <20260505-seg6-mobile-v2-1-9e8022bdfdb6@gmail.com> <20260519033151.b01e47a877b01d3b68931abc@uniroma2.it>
In-Reply-To: <20260519033151.b01e47a877b01d3b68931abc@uniroma2.it>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 25 May 2026 10:44:12 +0900
X-Gm-Features: AVHnY4L_KWEVlSdlGhMUwX9iTXuQg6B8YX1-k5ekXIJ_K-F3-WVsht3luuuTJjE
Message-ID: <CAGCJULO5HR0J7pD++_--epSEnzqO2p5Mn=UQ3LPbsYYPGydM7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] seg6: add End.MAP behavior
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, stefano.salsano@uniroma2.it, ahabdels@cisco.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291226-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniroma2.it:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 26A2C5C5403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:32=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:

> The commit message lists three drop reasons including
> SEG6_MOBILE_HOP_LIMIT_EXCEEDED, but the code does not add that one.
> The likely third reason (SEG6_MOBILE_MTU_EXCEEDED) appears in
> patch 2. (Flagged by Sashiko, the Patchwork AI reviewer.)

You and Sashiko are right. The new submission will only list the
drop reasons that End.MAP actually adds.

> Nit: As far as I can see, Link: tags in this tree usually point to mailin=
g
> list messages (patch.msgid.link, lore.kernel.org). Other commits that
> reference RFCs typically cite them in the commit body instead. Same for
> patches 2-7.

Will move the RFC references into the commit body and drop the Link:
tags in the upcoming submissions.

> This single reason covers several distinct failure modes across the
> patchset: wrong Segments Left, SRH absent, SRH structurally malformed, an=
d
> HMAC validation failure. An operator seeing this drop cannot tell which
> check failed. Using separate SRv6-level drop reasons seems reasonable. Se=
e
> my cover letter reply for the broader discussion on drop reasons.

Agreed. As discussed on the cover letter thread, the SRv6-level drop
reasons (SEG6_INVALID_SRH, SEG6_HMAC, ...) would be introduced in a
prep patchset that also converts the existing seg6_local and
seg6_iptunnel call sites. Pending the resolution on the cover letter
thread of who prepares the prep series, the End.MAP repost will
depend on it and consume the new reasons.

> This overlaps with the existing generic SKB_DROP_REASON_NOMEM in
> dropreason-core.h. Why not use the generic one?

I'll drop SEG6_MOBILE_NOMEM and use the generic SKB_DROP_REASON_NOMEM.

> seg6_get_srh() returns NULL both when the SRH is absent and when it is
> malformed (seg6_validate_srh fails, e.g. type !=3D 4) or truncated.
> seg6_mobile_get_validated_srh() sets *missing =3D true in all these cases=
,
> so input_action_end_map() treats a malformed SRH the same as an absent
> one and continues processing. HMAC validation is also bypassed because
> seg6_get_srh() returns NULL before HMAC is reached.
>
> seg6_mobile_get_validated_srh() needs to distinguish "absent" from
> "malformed/truncated" so callers can drop on malformed instead of silentl=
y
> accepting the packet.

The natural fix is to change seg6_get_srh() to expose the reason
(absent / malformed / HMAC failure) to the caller, which fits into
the drop-reason prep series and lets the dedicated helper go away.
API shape deferred to whoever prepares the prep series.

> Nit: the function comment says "decrement the Hop Limit" but the code doe=
s not
> do it explicitly. The forwarding path handles it (ip6_forward). Maybe
> remove that part from the comment or add a note that the forwarding path
> handles it?

Will reword the comment to make it clear that Hop Limit handling is
left to the forwarding path.

> Because of the bug described above, the only path that reaches the
> drop label with this reason is HMAC validation failure (when HMAC is
> enabled). Same drop reason granularity point as above.

Right, that's a symptom of the helper bug; both will be fixed
together by the seg6_get_srh() refactor in the prep series.

> See above: this only catches HMAC failure. A malformed SRH falls through =
as
> if the SRH were absent.

This call site folds away with the helper rework above.

> Sashiko flagged that for SRH-less packets this breaks the ICMPv6 checksum=
,
> because the pseudo-header includes the DA. The AI bot was right, but when=
 I
> ran the selftest it passed. Digging a bit further, I noticed why:
> 2001:db8:f::1 and 2001:db8:2::e have the same 16-bit word sum
> (0x000f+0x0001 =3D 0x0002+0x000e), so the checksum stays valid by
> coincidence. Changing nh6 to 2001:db8:2::2 makes the ping fail with
> Icmp6InCsumErrors.

Thanks for reproducing this. I'll fix the L4 checksum on DA rewrite
with an incremental update via inet_proto_csum_replace16().

> seg6_lookup_nexthop() calls seg6_lookup_any_nexthop() which already calls
> skb_dst_drop() internally. The explicit skb_dst_drop(skb) above is
> redundant.

Will drop the redundant call.

> End.MAP reuses SEG6_LOCAL_NH6 to mean "replacement SID", not "next-hop"
> as in End.X/End.DX6. This overloads the existing UAPI semantics of
> the attribute. The cover letter reply discusses this attribute-semantics
> question across the patchset.

As discussed on the cover letter thread, End.MAP will move into the
new seg6_mobile module under LWTUNNEL_ENCAP_SEG6_MOBILE and use a
new SEG6_MOBILE_* attribute (SEG6_MOBILE_NH6 or similar) for the
replacement SID, so SEG6_LOCAL_NH6 keeps its existing next-hop
semantics. No SEG6_LOCAL_* attribute will be reused.

> The selftest only covers the SRH-less path. End.MAP also accepts packets
> with an SRH, and that case should be covered as well.
>
> To expose the ICMPv6 checksum issue noted above, the address pair should =
be
> chosen so that the daddr rewrite changes the checksum.

Will cover SRH and no-SRH paths per the cover letter discussion, and
pick addresses whose 16-bit word sums differ so the ICMPv6 checksum
path is actually exercised.

The next round will be a fresh standalone "[PATCH] seg6_mobile: add
End.MAP behavior" series in the new seg6_mobile module, posted after
(or as a dependency on) the seg6 drop-reason prep series, per the
cover letter discussion.

Thanks again for the careful review.
Yuya

