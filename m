Return-Path: <netdev+bounces-261511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF7pJQSKoGlvkgQAu9opvQ
	(envelope-from <netdev+bounces-261511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:59:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7461AD271
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF422315136F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB39334C14;
	Thu, 26 Feb 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzDqmFEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3033263B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126105; cv=pass; b=SYSdsVIc5+ywX2MAm+5m5T3nIlG5X+de20PZNcjy2eqNqA3hitRH8hAJlCHGbN2YidjXCXZiR8XKsR+Nx2MTM0rTkXJjr7Wla8YHZi5IuccaQf8MaG3VPNq7M89+pErT07qZ2u8iIArPx0mh2LcsPujr3jdF1yZvmbCkCk2ao1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126105; c=relaxed/simple;
	bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOVTWG9MiAtzW2j9oOsD6T/zOKIx/PGpiPBNDaHOFbxjNwxr0GgfzEK3/lCbKLaMQ1VF/l937jjMNK43CWRe79+8uIgjtfir4gUjTxxA4kemULc6w7jCUF43yJmP0ZsBpVSVNARdf5ZIcAKWXyRGs/GdSIjQYKl0VDPi8bIchks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzDqmFEI; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43984d7e49bso998614f8f.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772126103; cv=none;
        d=google.com; s=arc-20240605;
        b=GPbT7lAe43F4UfUnkuZaJcErcPGJLhgtGZGqcEXNhPqYAE382rdFYMsiZy1TLxg2z+
         8rRVRALQVGTB5Zdn7EkR6IsXL65Ze+N72s3nT7rGLLDQVlCEZ4WCBAr4jqw9hzOQxjyg
         0iMfmImAj6lRHJTVefMbAWpugG1k2n3dsBBQkSsNDlKEx0NHpESCsgalIVke3bCG0HYr
         pHEM9HCHn7XcVJq+uCkd+o3bmt/OjXifZwZ6B1OiWuI+lS91bkVcP4TooGhNtkS5Fr2X
         0dP/440g9SUuKDKdaR4DuoFLygzV1rAthid4c+qGMDj+SeNvjajnj12PW1XfQ849kq4f
         TTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        fh=tigLG6J2Y6/V+Tzyvd2T2xN1BPbgIcdpoc94TVYsY30=;
        b=QJ6oGtIyJLlfWqs4cvPoTNdX4d3h3nPd0kLd01vEh5NS1FgrkZmsB41Tgw/R7x2icV
         59Uu0c7J0XQNsfrbN0Mmui5CmmN3CYQw+e6jdRfQVkJGpDgqHFzpiZjvQv7pedE9D/Vx
         f8DtyBHkEHSJSuQjwNp49ubkLOMEshSQJeL4YIiMAoXUy+Qgv5GRXZmBGg3IPakCrNbk
         LzPbI4sjrcC7IyKQU0MZEtw2c8wX95SnTQVruNZF8thhN3q9sY8giHxnWnA3dYdHnFmu
         lEVv3f2RINvp9eK3RQvoRKz4vDRqkKwkgUS9Ao4VT2wO1HFPk1jvYJEA91poeqZs+K2N
         ewIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772126102; x=1772730902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        b=bzDqmFEIo4JAtG85hOHWF3FQxAybMbfFMXbhIPY33poYlPM4C040fuQjL3y7AUtzi7
         aosBytL4D9b0XwUEtNPPq0AjtaQtsDJb46ixoKS0qKFJFmEEu4N1sE5ToDCTUH1DmjYI
         F9rQtB9zc2/2pOIWWAPZMqQW3TI3X/S3LlxRJeWFDuVzGlnJx3vY26LCWLKYfBSAIBIA
         t1MxuYNcm8VzLtGtkmZMqE1HBCirvXDzjEC4gwMobKUqUkUXn+diLvW8Y61L1iKyKllF
         3Sed31d1UKY85LqOwXIAIA1mCAlEcIdsPyqgZdkZs/U3r5yLrKkKW8/g56JKr05DKUt0
         BHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126103; x=1772730903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        b=of9BcffPYFnMnbMDzlmj47MVpYjM4CJT1MSLNt0T1omo7KDb4fhqOCI0cguLlNxJ/1
         0T8x3Xo6sKUFHyd499HrJr4ByC/Cs3+Wx/cO1/9fRiYVTaBzvjRduCfFQuCe+XNj6H2s
         Irc/9FRYCRNVdpreC3fMEQ1u2ZSCOScVIxn4IMdNZVZa3Ke0IfH9St2Eil2ZS/xAev7n
         IX0u78yLDrLuc2q+j5UzwK0VJiB19p+sRlBEj6iahMS5o4JPM0Zi2RyjBl/RY9X5SzyY
         mYMxjolFRRxjMCBJ9nlexx4Dl2ygYydpdxdD/5BTAQ0qq6u6VxjECtbY1tR/iX1lCrRs
         Sz1g==
X-Gm-Message-State: AOJu0YwYUKDT5NAA/edRIEdcP9w5X5+70rjuE+wbWqV1mT79OVgA3G8N
	ligaQ+Pj1wQD1YZGnLO306LJE3qISDrB7h31y29fHSnO3MOxRzDfB6hJnk7TIeYjPCrnz0pS0Qj
	xBJy2RgPW/4hj001tGA/TKGOro0qzLoY=
X-Gm-Gg: ATEYQzxag3EZKD1fJVHhtKAtkGyhWkADWohPEjtC4gNb4EmPn68kgvkf++paYzAtRdq
	qDIdtPbsuRUeAiUJOn32ivvxjbZPUe8FZRPBthV2PuEycz5DfKpxDLxul/TSWuH9KeD2uzSLv5g
	5nA85W/iqIx1LvHzHuhLmp8Gn9J4qVQICc2p4CsPcK2dp7SCQALj84pWiMzs7/bsJNkEVH18VJt
	ZwCMZaR8GbJikz1SJcTjtzTLXSc9+SAxhRiVnlAbzq7mh5A0QHMaOuF+RHMuwemFoATvpwOV5E/
	l5KAoPx7sGTiMxoR0ELGTM37t4rGOn61DteaMF/d3J1uJKmZMZAhXp7ommIodyB1R4aAskEVGOO
	xFa8CuqhjZpa9kvt9X2Y=
X-Received: by 2002:a05:6000:144c:b0:437:7268:8e1e with SMTP id
 ffacd0b85a97d-43997f4145emr5805473f8f.51.1772126102426; Thu, 26 Feb 2026
 09:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226080003.524935-1-idosch@nvidia.com>
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 09:14:51 -0800
X-Gm-Features: AaiRm51PaW7hQ9Mwq2-yjypGiahmbHVvHgNerWqvNgY6P4RhUlKwJC2t3ik6HJ8
Message-ID: <CAADnVQKo9L-OvwJYwFbGSCMdXThYU8E1=jz=uZY9x8_azLZCjg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: fib_lookup: IPv6 output routes enhancements
To: Ido Schimmel <idosch@nvidia.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261511-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3C7461AD271
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:00=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> This patchset performs two changes in the bpf_fib_lookup() helper:
>
> 1. Patch #6: Aligns IPv6 with IPv4 with regards to output route lookups
> (i.e., BPF_FIB_LOOKUP_OUTPUT) so that it always resolves a route whose
> nexthop device matches the specified oif.
>
> 2. Patch #8: Allows output route lookups for IPv6 link-local addresses.
>
> The rest of the patches perform small changes in the existing
> bpf_fib_lookup() selftest (patches #1-#4) and add tests for the new
> functionality (patches #5, #7 and #9).

tbh I would send the whole thing through bpf or net trees.

