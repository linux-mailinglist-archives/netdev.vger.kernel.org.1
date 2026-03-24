Return-Path: <netdev+bounces-270868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gcHfG9kSwmm9ZQQAu9opvQ
	(envelope-from <netdev+bounces-270868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:28:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E5A302044
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3AD305A417
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EBD24BBF4;
	Tue, 24 Mar 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYtuWiNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40F242D60
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326485; cv=pass; b=aXmJnX4KoWwgrE672eVqoydcvKmyoOUYFo7udPvJAdzm0PDvWtT5HCik0Klf7FInwhUKR3z2cdb31sWLaEQ2PeCFJlKs+96eKg/aSi3FdVUP3cdvLFthOboBrU9vdOCHgjgaSjWAVpEkM+bvDFqpABhkdsjcv1cBhNj0k+zNXtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326485; c=relaxed/simple;
	bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfzJhGJKbs5hoCtO002QKgwCdeEkLiymmlvQqA+m0T6fbXWa03glUR86KRvK7+fkXhCPAbgkjJCpd4U/anDR4YsJYlBUw/j8usEnh+MRuR4+FchpIweXynN9+3oXy9Nf/OjgHE1ptCARiYxmShzb7yJ8Ctt0BI/btCenmpqTXoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYtuWiNL; arc=pass smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-669efe709feso1509619a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326482; cv=none;
        d=google.com; s=arc-20240605;
        b=BhQeyrNXvHhu54SXGdZOpQNgBC2G9drR5ClN1sOnKnFqW400+Mdx/HINxZLDZ/UmDV
         XiM5pwOY06hbpK80S17IEMV39P1ppmEipavZWPSNc8FOQ2Dfia6dqdeNUySysQ51Z3Ra
         TJy+cp3KzrRyaUCJFKBXawXs/Sn3JB286IPcYyRzSZcarl1jhjoE6814+IfJNAqxmiKc
         0xbFXL4Hx32wVdj7eL+EpuDwCBoaSV5lCP5FAVA/mKGmFgzWZY+9PdcRdv4ka/1C/0/Y
         skZU0iaAhFYbFoA7mHqTeT4JUaE1Df+jtyb7vo2EXDpG5YpFxjTf5zyB7SjHf75w+eHW
         bU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        fh=Sg1BNzItZdOS/Bj4Mxx8OE02M/iFBEmO4/GIagCs3pI=;
        b=fyk2Weeph7Ki714i+D/OjaM4qSgBBvxm8IlQKn00t2B7gAWyrQwrnvE47pB8LYX6n4
         NEgYYMTFaTwGKSKIS07UEt+FyZ+kgN74HlNOmALWr/79j1KvUC4fL44EE6mUnWvU1ggu
         FEijZSSTBcWvurkQW/wczV+6qvG5SSn+X6y2kz26h/BWp9tfPWKLamjnXt2e87WdyGqt
         lfsLn1harC2FoofWZDLMyzTcEtB3vrK5sPULNiE5duum4Dl2MxRhuiesteP+X8jO0OkR
         4lKGh86aF5y+wBgSG76AtJsY+CDpegWh2rfVg2jGFUQesSf1R6oJQoedSAZbsd2fMaSE
         /98g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326482; x=1774931282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=RYtuWiNLJx8R2b+1RiJZYf2azakQdqAi1ykYm0/hZWwIs0++0rHOLlrJKs1SRXw4Zc
         Qs7r4hxOykxbFtU39S+D6Az9RneGmw+ZOxuZmdUXftQkeZjWpkY9OCoR9ZEmgCZGwOzI
         +prX6Jpp+qhOBEgtlIOeA+aUMh+mrwwZ0bew5vf2Qskt5H6TuxsJm/BYkFbhlbv70XwO
         t58pflR/BffgkEgTylXgwE213zVR7ZuLyq417/WcCspXWVNLjmEIzjamC2lUuV0kWL5K
         XAz/XGdgil5SIxl2LAlX1GC4Fa4jCHk/S+ha8N0jSsepbSLuW6M4KQnSoDXhwXOgYAHg
         Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326482; x=1774931282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=OoxgSwsPH8XtE2iaeZUOH9tXHNc/lpO2cOvlHb3G1Dy9AvS4Djs4vEi0Best/89z/c
         n9vRmC1gTcHWb5md9NxGqEt6S6lMqgAfZJHwt+rb8tQUpJcTyBHYssThpBL8jbr4cCK3
         rqFW0xtL8UaSEZTyNjBU/zJN5zetwGKDEHXOQmF+yKnMQhjpCJg/6Ok/YJkjJgrh1vjV
         QS3mYcfCotuoLX73bJV5ybpVRzEEn43Wikk64UMSuCQd7/8EkMnFwftCHAfyLyUfZvPs
         ROz0B9bBIDnp7iQrHTIt4afyY+hKM8NM6aQGVD0Kwu8kh5PQQA2FGjtK3IPRZBHpxwqJ
         BR5g==
X-Forwarded-Encrypted: i=1; AJvYcCXzLntNg1dJOdXBnmwR7Bh3CJE1zSaden29PoA8cx2Mt9HUsy5ITrDaPnagZ3YbX6A+/W5XPuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoeFTiHqS8ZHDx2cjTW4M7qaupVtCcaSn6vUUL2kgV1EltjjT
	sPIdnkQgSNfNZ+4bB7jMjhIo6AgaJKIEgNC14n8zuTJt7WnmX2TdNWrrf97qqUypucojrNFpUmj
	kSYDqDWpvEZMHmnDuq9jQXgrDD0YrcD8=
X-Gm-Gg: ATEYQzwHJky/okCRUjaUR/fU/R//OKaYrmMaCbbnCq893GI4JCAQt4W30RTH+wBZqka
	LN14jmYviQil0bV1SyfiDfxEW7hRgTBL3xJSOgr6W+F0pkkEDNogxWexDg/I7spe6MrdGFVomAr
	2lttoINZjYMG3jzJRJ5t41j7Km+xYg0QbFy/GYf9nGead/w0KJMp9/DK3eY3+PRtPptFzbjvi1J
	HzoJByCnVB5YUXkqidV0jKD8Ed80BjKequYPaVLtVB8EgPtGFjVfZYRvUAuhLCzFnwTYWtICu6d
	0NrchZ5G9jxz6apN50fL+958TYm6W6qNapvW1cE=
X-Received: by 2002:a05:6402:270a:b0:66a:3419:248a with SMTP id
 4fb4d7f45d1cf-66a34192961mr1158702a12.13.1774326482054; Mon, 23 Mar 2026
 21:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
 <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
In-Reply-To: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Tue, 24 Mar 2026 12:27:50 +0800
X-Gm-Features: AQROBzBgTmKHaA7x9bBR6YuiaU8Gh2HBa_zkliE59q0Q7S-SffyKp90n7TFmYBI
Message-ID: <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270868-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 92E5A302044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon and maintainers,

Just a gentle ping on this patch series.

Following up on my previous email regarding the testing methodology
(using virtme-ng, verifying the Oops fix in Patch 1, and confirming
the strictness of strsep + kstrtouint).

Does the provided testing information address the concerns? Please let
me know if there's anything else I should clarify, or if a v3 is
needed to move this forward.

Thanks,
Yufan

On Wed, Mar 4, 2026 at 11:28=E2=80=AFPM Eric_Terminal <ericterminal@gmail.c=
om> wrote:
>
> On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> > Hi,
> >
> > Thanks for your patches.
> >
> > I would like to understand what testing has been performed on these pat=
ches.
> >
> > With the possible exception of patch 3/4, I feel that unless they
> > are motivated as bug fixes, these changes are too complex to accept
> > without testing. Although the opinions of the relevant maintainers
> > may differ.
> >
> > And as for 3/4, I lean towards falling into the policy regarding
> > clean-ups not being generally accepted unless it is part of other work.
>
> Hi,
>
> Thanks for the feedback. I've verified the series using virtme-ng and
> a userspace mock harness (for the 9p tokenizing logic).
>
> Regarding Patch 1: This is primarily a stability fix. I've tested the
> error paths by forcing init failures on a non-Xen system; dmesg
> confirms the new sentinel-based cleanup (NULL-ing intf/data and
> checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
> during teardown.
>
> Regarding the "complexity" in Patch 2: The strsep + kstrtouint
> approach was chosen for strictness. I've verified it handles cases
> like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
> latter is now rejected with -EINVAL, whereas simple_strto* would have
> silently accepted partial values.
>
> The same applies to Patches 3 and 4. The migration to kstrto* ensures
> that sysfs/procfs interfaces now properly validate the entire input
> string.
>
> P.S. I used a translation tool for the message above, so please excuse
> any awkward wording.
>
> Thanks,

