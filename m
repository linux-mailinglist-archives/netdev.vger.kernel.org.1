Return-Path: <netdev+bounces-290008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCdwCZvrDWrM4gUAu9opvQ
	(envelope-from <netdev+bounces-290008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:12:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64059315B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDF931B0B69
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126E356752;
	Wed, 20 May 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYbP/aa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EE3570DF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293729; cv=pass; b=bvza4jcwZh3QKl1VrouEkK7SEKu7o2CJam9PbgG+yFzZ0IkK7XiwbkQv059W2u2Nfd4vUVkmteZ+Es5rQGuE8714ZZEbyz/02F36yVxsWaqpNi7bGvWD3O4vLMY242T3lGB5dGFnAwIRv0DO9b2fmIco3//r/SdVGj1pBeS+tno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293729; c=relaxed/simple;
	bh=JKxF9mERknSE7lZLZj7DBF4Zib3RcqW9UlhDD1cBWUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3fK7r0fhSoXRkCFZ8MecxTL7dugvxJs9y9hR5GYoicGO1cNPdSJlaxnaDEJdH44jCL8r81d9cjHAqP290LgpAwq/KuMC6ruoHcCXkiAJa1ecwSfIem1zKyq25rck/fTzKcIkC2j0WdkkpAUfh/zwn+o1igDbf8UhdHQC4H87ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYbP/aa4; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651b4d09141so4954180d50.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293727; cv=none;
        d=google.com; s=arc-20240605;
        b=UJx31hVtjTPyUsSXwI9UHM//+okTOLHT7x8w0MiC29EfxLuQOvvxN5+Orgf90S/pii
         1RjF4hg+TZSOalFz4MQsPWQfy3wfZG6IaaaA3vgpUA+N4WiGF5XZE8gNldAFq082Q9z/
         1zqwAje/sPkEA+uUbLk77lxvI9AWDIExPh9qVaySkft556AbRyRaeHbZRvVtrjnX1iar
         rJaWD57QlJf2D1LD3AqRTKCd3dC1JOCDQ1or5nIcV4sP5GIB3u8H9r/pIXOoxl/vLubD
         O7zA+cpfFWoDm7HRQCMeV0spMig4vM+Gk5bC0h8nX+fldRJX6jcZ8bEU0UmWyUEV3ivr
         DzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        fh=KtOQ66g4LJ0uvfYyNtI4w2sno3o+IYg5LGmvauD3euM=;
        b=VGnViig0/2ZsTziPWgSaOpPOeKQDZ9KfkuBhkUlZC/naIZlQ4CrJ0stTbaXW0GZczk
         BWO+h2Jb1Uf6OBtntihH9UvCDJvQbjXmrFhU0X+fDbXvxI3LAsnCu902RIumv2WLIHYa
         ByTptIE0UBDbQ6c4XK9wiH9XnGqlp/F5k3jagU37+BAkS1sendjEB+mcVPTZZEJTaHdx
         hTZ/eKMCHvezTpbhcXSCf/8gN7lxHDXRujLJnbqhAEo+f7jTX/3UR7pdnOCs6u+VwUwO
         0uvRVKQJTAFkABTDQOxA/HdDBnceQR/gJLHLsViMC2ZLvK7V0moKKEPtjZhgNf9ALs9W
         crGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293727; x=1779898527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=oYbP/aa4DNiUSrjan9DSw6AH1ZnmhqQQj1Eb64Q8HSjslVtHUia+Z3lE2lR1DsSQeM
         WDN/FLqeDiEPH1gAK3jqZ1aT7Ye2hX23/2KqnXg36YcN7kBT3JaylANQp8SKzVYEF99N
         OhXtLJBVMLfGFQO+L3LqATJonCqf+GPbF7udOCMRobPjSsJmGULek2G3/ATE4Womh+3W
         fse9q8orENg+SS3FZcgjmFlBQClI4a+cGzTyxn0Vr31DTgk/BgzKnNyA+pRZPeuJDgxN
         +lA7bbbLjwGisMystojo6jPFAwkcKepfm/UjilNcXhR1mfulUJlTJjxS+YL77dS65lrO
         px1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293727; x=1779898527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=jKi3eqB+gRynUWS+JN4EZ0MxTiTKfAHCPS0uiyAP1itYLuW8a4egakZNa09u1E5Aij
         aGWhTAc7XCKWF8MhmmqG0fL+MMowFJC8X3gpHKJBNhNARDpPVDkx8PDO0gh667aRh+80
         elwUfgb0y5TABnzyCTsgqVbYf/oi9JDjnA1hhd0zxsdzp5efAXzTJedSNyHFlXKH9tCv
         sGk+Qn+RjPbVeZ+NLVQnBUwx2SzrEegmOBXSos+I2zQdg8W5iqeMOEFZYmu9DyTOwjU5
         HNKLfkiSAaJgk+zag/EMSOCCHw2pGSjOYwruayvEH9UqcR1Pi/VHvELu0VxI3wq70Kei
         IQWw==
X-Forwarded-Encrypted: i=1; AFNElJ/hmlhYFgV0QfYKUM3EJUNfETzZIuOxBEBk4i4/Z527WSQlQ1qlckxc25J51u2c/N1GaGDd1AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwmgGjcuIYCKfhr7FYEYEgUC4mqk4XaRsUcQtLgbHBEts5hRY
	MpUKa5irIwgqZK6v/h0QZt385xpbC3NWFqprlwFhuJ6+9kWTcj9/ut19/O2l4iL2IM8TeRDxc5z
	XovPuOYXazagxC5w0Ocn5VFAqeS2TlNC8pw6wcLk=
X-Gm-Gg: Acq92OG7rkLiCniJMPpvlOmfnXdDfyqzbG5kyd44fJf9m1zg1yXJajMHcASEruxjzgK
	aoCUpnoMKlGh4ODfOUlG5iXVdqfe9WuBFW+pxDQe6RxdNz1fB7x2vZ6yCaBkEagnRmg/CmPn7VE
	BRHvIR8B/RNrF3Fh6LhfHfoTtq0xmx5IaZ5DTBCvTC4ceFGyJLreN//qZea4nTdWuxI/z+ekx6W
	RzddW7fHGvJKO3uChxf9q+LMaRBOfjTtuNjHQh4E+Y3LylKZSSZpJiyaNQ3JmKr4mYWDqXS4CxY
	QWp5EnijgzYX8kRjjS6eLOP5piNNYsOdQYBmSJIsS8cyoMJwyLbB1ame1l/eMBXoDG8=
X-Received: by 2002:a05:690e:480e:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65ea8363d6emr97017d50.30.1779293726841; Wed, 20 May 2026
 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
 <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com> <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
In-Reply-To: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 12:15:14 -0400
X-Gm-Features: AVHnY4KLzY6qZrOAlROfkxchLK6iuGJuEWScellTpWFEb2rNkqndHXLtgHsJKfM
Message-ID: <CABBYNZLzYGJgq=U1AHm-xL_hMCaOFVrJTnSxyqQiqjKQ3JUowg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290008-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD64059315B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 11:23=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > This coming from the spec is priceless because silently discarding the
> > packets means the remote stack won't know the responses were
> > discarded, causing the stacks to go out of sync. We also shouldn't
> > process packets beyond the allowed MTU. Therefore, I strongly disagree
> > with the spec requiring an identifier on the reject, as this implies
> > that even if a custom MTU is set, the packet must still be processed
> > if it exceeds that MTU to find the first request command within it.
>
> Should I keep a verbose comment string about this rationale in the
> next version?  This seems like something that might trigger questions
> in the future if there are issues between Linux <-> noisy/buggy
> stacks.

Yep, be as verbose as possible, and quote the specification whenever necess=
ary.

> Thanks,
> Mike



--=20
Luiz Augusto von Dentz

