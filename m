Return-Path: <netdev+bounces-265148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCD8H2pErGkOoQEAu9opvQ
	(envelope-from <netdev+bounces-265148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 16:29:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA122C681
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC3930151DC
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FF3A4F3D;
	Sat,  7 Mar 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlmlqFhu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E3909BB
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772897376; cv=pass; b=IuM9bE5MF+4s8DcuzHWkNpitZThTbyKzyLvOhNOqMa1kcp9bMC79AZHY8AGE8ff4wNv5wJVXDuvUdnTouOLBfdDdps1pR9HNpzxpSQy5ucPREziX+3M2EooH2P2DmDDu/zhOOvY0Ek6iEN6jGArfKSz9W80O7lvCYNHorsDQYMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772897376; c=relaxed/simple;
	bh=VsDM0AVU9gjPoqNbgX5cOuOw2ysEjtZpJw31SZhKE9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksz0IOPWbRbdKgxO3zKe5J7yCqzhSVzgkmkfTmVMMZCBFgMuwB67s+/5aHsf3BPkLPLPeswm/cEjBJENA4wrEiYgJnx2zJ4t8QuRkjh3xF4fJM795KcxFmLSThbxZkZtDpbnvmCaIebnyB7hJJPtxe3AoKzn+uJ/sT5pIFkCvjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlmlqFhu; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899f27df3d1so68582096d6.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 07:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772897373; cv=none;
        d=google.com; s=arc-20240605;
        b=UNdPkj68C6tApU9iCJxgIuZMWAf8j459JQbx0zLcwFGnKwomjAbDDQfypjs3JpGAJH
         xNfJyubUJ/id7o/lJGc+/SKWdaurn86Hd1a3wnSZfWdkJg37NjE4rrkKDpFjuiaExijB
         oqAETNwhZ3v46zxgcbXw7jF8rFxAX6QOh88bsqy5jolrYOS8WN7Swhe7R6gjDQZ8ftT6
         yRjYt4Lm4jMGX63pn9gyCePDka4Szkdwn2JO97Jiox0xNtBb6Sr6J3A8aTuYiV6okh78
         mUavN8oPXYxSOcg18sNed86BYLy/tzie7u9/KR37qpfAKArRvRtU13o5kbMIFu58xkFy
         mwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VsDM0AVU9gjPoqNbgX5cOuOw2ysEjtZpJw31SZhKE9A=;
        fh=VQ34DQaQjPrnb0josuBzhwyYdsYFz2mnyLYG7C/20I4=;
        b=PYr5rr5J3APMB0FUmao4kovpc3kLHKAXVukERXTepofeXErbTA2UgwHpIHCFWAtgKG
         aCKy96pWhvFgmiRm0euQw8FtZZIculCONR1ZJj1RT5zLIs3GjSeYS0Wzcs3Og5wJLl6E
         BqqWsW1vECGs1g+xI9NamIbcCGVfHXNeEgGgymvJMkDdmvcEUZpo6/mrHr8UBvJTvST3
         7/hshZJQ3TK6D0ToTrsAkZpO8BvjMIH7ow6S6xt+hNeEfEkBs2vOIMN9fqSMLr/qgZbk
         nLLx7x6IanQzM24P4F96VVlJIxXFzv5zcp522TMvhr9XR5d48KdfMO00jIug6WyorYw/
         xNYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772897373; x=1773502173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsDM0AVU9gjPoqNbgX5cOuOw2ysEjtZpJw31SZhKE9A=;
        b=rlmlqFhu0LOHClzJVMK+Mvma2Vdm9ZBguyBwi8co8TRDmEG9RXZDzAAt7qZ8tr4GNX
         NFT4OIYt4CBfU3YD8HsRO7YK6uUn4xYseMd+f655jgGQjR7R7uMiY0sZAYGjw8vYep5P
         4P+hUOIoAAmC+HqzKIW5ZI73lSmWnoULU5arsee7U4MDh/LVhL49KNISTKTYvhY217iT
         W5922AHHV9SVBvLL7lqPHoCkvqCP64w3S8HITRT4agJaoPbChouav8/BMFJSV/2FIAJL
         3fNB5nfG8In3JIkzl8n8BfHc1ociome2o0mA31VdndsvkLj1o9vLBHoRo+MCIz00elPJ
         3E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772897373; x=1773502173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VsDM0AVU9gjPoqNbgX5cOuOw2ysEjtZpJw31SZhKE9A=;
        b=tyVNqvgVmf/MU03ELci/PgXi7pt3PDL3jx1fVb3MP9OLIrhGvmiXpsWXlqvUzTqs0u
         BWsSG0zo+n65CAN3PHwuXAC8GRY3xp+N24M+ZDzH7Md7KYK6xsxqqAeo4JQZ6QycrjQP
         HHeMGo3a3udD4dBjld7atSRzE4NCftk2z3zsk6Gz1XZ94ZY/CiHhKvc0z03PqIuL6R34
         nZnFqzTDjW4hTQbD4rW9HQab5avPFhblMxk0O2TEMR4XBu1ZQo3/owdqrRp0Q8MdzTJL
         1+HEob68MEuHK/68MUJ5qJFXTt2G7J6eEexCpS5DDWaghOcjDIUPeD51gaChoauS5YOP
         P3eA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ZXwNudvgGel9Jvp275GuljoC0MMW7MBx6qi+ebF2hkmIL7lQc+nOlooDWVQzTy6CPEl9Nc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLPWegRRxKRrrDhXg19V2OR9GDSlNygGggRNg+s67NvXIuBeX
	+W8dMa4Dpzzoz387h428VcPmC79Cpjkbi9zSDMnd+lOyCqIycX40wapBCVrxsXAZcnWaFMDmMTt
	KlM8GmPEbbo0gdkIv7J6x5DXInMyhTwgBDis0VlGh
X-Gm-Gg: ATEYQzzeOtp/JfkBnqd0I7QkAqDoxgtp43zX+LvjTMZEzfq5iUeEF+WzZ2bNexIm4Pa
	qxnccp/4l7jhOsf5kkmR5Vdmqy3A9dxJi+XEw8N6NNAh0d9BLhw53VR5K9iWyoZkxBKL6Gy1pg1
	mkHErm5t8FLXFmcsOQk0zEjGJfovnaPu9/k4hGyEFS5MH9Ns3j/1lfN7RkNAHWzlWb1X/W8K46H
	oKD9/dmBqPffo8zR1eFmCSjKg4UlAI5Pd6XESrrhTxlvbkGerPCoPalOOcS6tZqCQkgraB27gA1
	szryPtMC
X-Received: by 2002:ad4:5c85:0:b0:89a:149:bef7 with SMTP id
 6a1803df08f44-89a30aa02aamr88639506d6.35.1772897372845; Sat, 07 Mar 2026
 07:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307051619.51685-1-kmta1236@gmail.com>
In-Reply-To: <20260307051619.51685-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 16:29:20 +0100
X-Gm-Features: AaiRm52whTqPcKE0BW2Xlea7pqFf7u6s1HPjKWOFClEsMuaeN3NPRMLqSdQwXfI
Message-ID: <CANn89iJ5xc3onbVnbAsdThXKQL2Uu1XpVYhi_9TxGJE=r38TmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: remove unused hash_size from struct tcp_out_options
To: Keita Morisaki <kmta1236@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D8CA122C681
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265148-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.935];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,cloudflare.com:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 6:16=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> hash_size is declared but never read. The MD5 path always uses a
> fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().
>
> This closes a 7-byte hole and reduces the struct size from 96 to
> 88 bytes.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

