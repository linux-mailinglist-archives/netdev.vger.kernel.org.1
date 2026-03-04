Return-Path: <netdev+bounces-263746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBveKv8OqGk8ngAAu9opvQ
	(envelope-from <netdev+bounces-263746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C81FE8F4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03863304704F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D884B3A6F18;
	Wed,  4 Mar 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8KnR0lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C5342535
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621510; cv=pass; b=EQrnx5Un4tijagJsxnl7QmTgMn4PdXetCVljBM6vhN+qsbuP2w7gh6JsRTjKD8d4t6vsxA5yckbRfTGL3SzoqGfos+o7OfhGru64BNCpZadSI3rgKgaiQ+weahMFdYT/bwr/BmAiwbE4kRa2uL6KlE0rS+mDLjGVoRueuMjr05k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621510; c=relaxed/simple;
	bh=57u5vhCVP5EEa+FsK/c7AMFO2KyXey8UN5xlwACjIv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXbnvO2qbzhpZHlzrrcsD2r8iuGWeHW7AWSFeO0EWP/FHqeBLQ5tAZjaGBkLjdOe+KMcnmL4T1fWq+1M9krHakBaNS3o1nWn8g9nuyGf+9k2778ySia8yJe1tpjJC1bHita0CJFgXbt86qI2bLoFhHyqKxN32zq5m+bET1uLHu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8KnR0lr; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79853c0f5b9so57758397b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 02:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772621508; cv=none;
        d=google.com; s=arc-20240605;
        b=AMQcrcdUkurFHOf2E43gTo9ObJojtV3LjT2z7OmHIu3lNa/Xz9VdDMUdQVxiGwDhQv
         OFn9EDoglUkijkA/6tgKTsQPGbmzJNdYkGdCNKdfjjnz166x1KP1DHRY++Z8rvDq+8D6
         Z+IqxBNKmhHi/TP+d6z3tIDbGU1curmPTMtRym9QfLLYLakY+QQrFh3t9lJZz46Ts6Pt
         EyRT7mnc+W0UYdgJ4nbjkoP7qsg+Gp8FSVcTR/B68X7Ar6SqQ+jnTsK1AlIb7Xn/AwOL
         VKOna0ucwcwnHc7hM8sRxzafBZM0382X7FMzS2a6rwF+KiuLRHRiZNpVKngfcOcXkq7A
         rnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        fh=ScFsnhXSmwlh/0RVj5+t5cGr8d0hOW1+h+Io+V+cv3M=;
        b=hMYvasQ5bfFGrgW0xD55bG50EnR8XQnotJ6jegWE6R+Z2NWwN9S0CWraml8TH6Dq1M
         yVgXNXE2lIT3G6ZYKYvsdX63KZEF0SpDgHf8aM6F1s46K07T4Eai7pjSIET3IhqkNSJV
         H15u1M/eWZq+IqUCN7IdWgBfiX/WATDzlmtpkbZ6eTxbPqAV7LBz9cOSj1uKdA2liglU
         Xlmoze2OWOxbsqsPVUPMbaizcNGwEosHqaq55SdA4wuFuZD24LJe8NX4tu6HQjIk0WJH
         o1hw6J2AEZhPP2FrUPevVXYTFx6mhf7s5omJBW1pvYqqmp8sk1QtibMcsAPBtaNKNo5g
         8PfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772621508; x=1773226308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        b=l8KnR0lrH2nddb2FOAdsXr+wCeHVI0lPlBJ9Iz7OZnfDnV27cA/N58Ro6ZRIBwl8UP
         KqJm0hqFaGPqFPrzZ8XSp/Fp2XW3ugYfAODs1qMH340C3BVVe/VvMrIxyIpjvM8hamR0
         C09NAj62pWHpZ8qhoAlN45Vvq9E/eT7g/ogMjHXefrwpZ4MdueRUq4lHxIdatbJvgH3M
         vTQ71NDBGY7wm2vDRsVJK1DO1SlxL5QIHzBZXhddvNhzHE8dXLQ9GwFUSCi396lPQwfg
         +eONPCqzD4ATW+ogi6LPD24ZimO0f29h6Ur1BNRfI48+vIRK1hJSTn1Ym+hPmqUf6O3S
         2Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621508; x=1773226308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PcEkYoFEI5voGPr8pCPoGCSxgYeETv4ZT/GQQL/KoU=;
        b=H6AiIXfzpGoQHS489ivlxYAL5cYdsxzJVui6B4Al1S1R5WuoI999hazGUdGbsPMHM8
         OuW3oa+ub9nQrtRpeVqaRpmoh5cb7CUl4ikTU/ydtXWKOsYPiAdgOZEyDpxWEOqm0ses
         m5zCHoT+/zbDXZdxkF9lbK0AnKn5O526aiYedjosCM6sE12aPgIgSl2BLM0eOQJDSoFz
         BsenZI72cv6qdC6QV3ClrtClpOaWSmOAwwQYCkDvsMaD+hSeux8madtD6ApSBp9dWeyO
         IXPct1svdTSFTEOpGWfKZj1GYC9ISi2WSW1OzRgoE/XsI3qNideVIuIcg3shE7ZH7dxf
         Ut/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPpiFimI3dRJBiO19cbG5NvCjbdMpnnrETXkq8gnQ/gRWpR2zLa74Bl9l0f/2eKgLB//rFZyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddvlmUEp9xBauPlwdClbQHtITUNeL0csQPniI6MGrYQZi1kO6
	wUv6+PZr1Xm3gycVNMBJpdinKMbozVM9jh7nuXwS8FaTkIckrJE6cjfPwJq9+sfdxKEm0pJHVVj
	GEornHV8iKjiwSo6vAXzqDOp9w9Ow2OptAx68Taej
X-Gm-Gg: ATEYQzz8OusvOfoDVOZm+oEnPpbDUWnvAzsGwQY25eidkBx/YxBJ2Vi0l6EMg/D8XxG
	iazAMAlfZvxBcF9rbjBBB5pWjWBUyJng6K+MFnvcy5W6Xk7P21+AN8WA55zuv1qv2Ea5CMS4R1S
	f1niVhGWXscPpEBQ0CN0lLsej6wiXAsVu7kqBOduSTQP0oWXOzvtjLdRw6jKcn0eOWFmu+LKR/g
	d15Us/QbI2ZebV2yHceWbIkgmJnCkuh/Dy7repLgbpL30MQ13NhbeiIUcXIHrhW1C3zVuatR5CL
	i6AAJLfJ
X-Received: by 2002:a05:690c:289:b0:798:caa5:cd31 with SMTP id
 00721157ae682-798caa5e3abmr4129457b3.66.1772621507369; Wed, 04 Mar 2026
 02:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303100439.3172296-1-kmta1236@gmail.com>
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 11:51:35 +0100
X-Gm-Features: AaiRm52fwpgkHQRhYeOQXh5WIYeoMabF6E2KRsY4-7GtkGjYqVvq3HycuLPYk-s
Message-ID: <CANn89iLt6xx3hEjTLEAv06G+4bK3TTti=H4qDgS4LxWSwyy7TA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 106C81FE8F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263746-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:04=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com>=
 wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

