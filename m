Return-Path: <netdev+bounces-255249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MwqHC8SfWmiQAIAu9opvQ
	(envelope-from <netdev+bounces-255249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:18:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62EFBE5C6
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70C603012C4D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948934EEE1;
	Fri, 30 Jan 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMeCeMHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CC348896
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804332; cv=pass; b=PvbmppzngqVGRVX2Mo/wo/q4Tom29FE35fbbWRE1Xe6pOeuPjdvJuKqkjDLIRRlN16a0FFoSwNXuwaXXEGMu71Ea1GLUxRGZRB+RjIHJib6BAIj+JQwCNdrb84ghGVQufmX90Z7D+NzMmCztW5pmtGWFi2YBmDwazhyoBfCGCv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804332; c=relaxed/simple;
	bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3fOwO3Nzv2C35cOJJX9qwku8AEG6aojDQZG+EOBsk1pHfThL5ggQgKgGV+/hL1CKLuvjCrT+AyxMS9KVOqz0o+rmzc3Fod2yOdm3Vod019590NxBi3XbP6/Zjia+W0CuAFmZnWtPdyJG6HjeiPbsQvjcM5xdXRGrfbP+g53IJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMeCeMHP; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c711959442so285424485a.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804330; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCbjhfy9kT8dRgHVAwSJIdeJKMbNI0P/8egGJWfUKRaN+hLgYkuJ05CvFVBlBO2qlZ
         SZ/Vn0kBT7hTVnJBkVpiYaVVUmji/3yCygRjS/0Ll2kj4wniwKIJV8Pef5oCuCDOVVZH
         BBuqQC16ZKLLJmf8qcvZBootUZvbTqbQ3riNiS0V/bJU7MTqgUMsseqhjSjrtea5Dv5c
         WdpR7ZcLX6YyizRS08jbiEjTfgWBaA5FCO97cnB7Ims+0MRCxPMUbtXwPhIFKNBRfE0Z
         pI4eFfloICeKYu54s/4PQ/o4xHi9FPJaUJU53FyRJXm+mMzu4FRBcWn1H9OZ+w+WlQII
         4+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        fh=FBk2wPEWAVINfl/d+Kktv6mQYIIYNBMCAFKt57xd9WQ=;
        b=lH7C731y48qFp3ij6KjQlhatO+3QSKN7WEFtIEbSI5XQ65G6WOpKc09mpy3jiLG0av
         ukioLCwAGRv0n3LemSrJURPIhtWiplKAKkMCvdVd1uadvWtw3yFCHIzsplZfGlS+tTVJ
         uAC6DcNgAz5plsax2sqbofAfUnd1crKNw6A+B65PMs8JOJ5xjsjcVB+I3/XTRtSIA7M5
         iJzZNFJDCb0zXwyVOZTe/aKH5E/1P/1Z8WGZBlvh8QFYEb9vycNXfwtlYk3WWeZLmejV
         UXkxEPDakfsCcSF1JNF+7TJPY0hIyolQtV6u/+dgEZPAdrFL9E/2lNb9gCCSeNxl8p6I
         IkDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769804330; x=1770409130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        b=WMeCeMHPrEvbueyYRJAyB2aIYAlL/x6rVOSh8qE4S4JE5TfYFjFKN1VV/OjITltDJc
         JfHaaYUpEhSrIW7lQaNNd52VCjcrGk613U5NwNQprBXr6Gf4HmCsoo8ut3wsMXykZ7Sg
         rvfGBL612zhBNme+sX9apkbdSahEjAywA8+Fqh2hWM6XPFvJOS95QIMZgPosnV3kzqly
         2kPHhWsdQuvFCjX/QTwqpVzG1aDjUPbM4W3G9N49wL04Zi1+enSXUBqrLnytS4y1cYJ/
         q2eeqfNTPEsGTq3HzBkTCbiky9MzU3y8XzgxaE0oByDPVLhRLh0AsyJTQYVg5ZxRlXCn
         NmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804330; x=1770409130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnNhbflpDXd0E2GUCIfx9K0B+gy+MkR5SSCXcr1p6RI=;
        b=wPdZoJzzeMHMJEtA53805X9kBLJKJcpTC2ZuBDMycFoQPNqmoTK/pSEkkURvoMi7ue
         KA/450FSIBDqgFzhXerfio7DoRbJ/udT+Iyu2i8ebMNPFzOlUJTNJW7lSsdo3GIjSl0K
         17egQtxvg4gjPy4xdoKzgUXgW2LcSM0Bvsf4uGHVLkhVAcLaYKkdi9kq5ZJBYrk+1V+y
         GtAWzfd3JzwWddUI7MrpnSVQFPr8EJft4nvp+bady9WGpU5FwZQDBWsmWMVA7n63d160
         4TuYVd7xgFBKdAsp2CuwwmvEKGPwEfLgJH9WzoNwuUUQ836ojbt4mJjXFb6MQ+6aMTqv
         wSmA==
X-Forwarded-Encrypted: i=1; AJvYcCWyTi+fq0Re8BbBe0j5mfEAXvXD1wAsPBra7oAR1U4rALIF7IT9EyGdLIuTmQe9mRLFFQweLPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVBjPBwMQlFavep7HZA8pFEhk2he7PoCwmJx38c7H4HOMq/E3
	f+IvciCQiWaQDEfjZxeM+qOy4Mh3v2YqaLsaQxKNI/oZ0FaceZlhuFbJkJhwC/Z3iRZHPUvzpf0
	46z54bjh6A2RX+yyxJcWb/dCJk/STBGCxZBkfSAQz
X-Gm-Gg: AZuq6aJ9FRXPqjkeLQLmCJ/niisb8qvd8YYP1pgO3zB+E3ZG6PodJnKU4qKTuvpgS6B
	9jqD6p0iqT0m20pnuXbp3n340AvNV33hpcTm3HYgtvTUwn/hA20NH5shCwdWzRpF5Kn2XKIRimZ
	DIYP3IACBF79i6EhV49Mdwko1ylRrZoRGS0iL3mitklqKKMlOeYGe83Z8MZCNX4yKfo24MR/VF0
	ki2ztNjp0l4CBxeWC6mNdbHNfzakz5ALhhJr52O5eh0SiX+Y/bLjSMlub0/B7/7L9WWNb0=
X-Received: by 2002:ac8:58c5:0:b0:502:a218:1cf with SMTP id
 d75a77b69052e-505d289d77emr53380761cf.4.1769804328557; Fri, 30 Jan 2026
 12:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org> <20260130-net-next-mptcp-splice-v2-3-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-3-31332ba70d7f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:18:37 +0100
X-Gm-Features: AZwV_Qgee0kWrUcrGSbV870oEmI0azfGZzvyJVxkG1CCnUqUQKho8S6iTRt6gAQ
Message-ID: <CANn89i+kMpgCa2F0c+Y3av0OfbW3B0gf=TEMQD2r_cEVixEpqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] tcp: export tcp_splice_state
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62EFBE5C6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h
> so that they can be used by MPTCP in the next patch.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


Reviewed-by: Eric Dumazet <edumazet@google.com>

