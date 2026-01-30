Return-Path: <netdev+bounces-255248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMlXO58RfWmiQAIAu9opvQ
	(envelope-from <netdev+bounces-255248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:16:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF730BE5A7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38C413002B48
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AA5313520;
	Fri, 30 Jan 2026 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4o6mDays"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7A2F83BB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804187; cv=pass; b=eTo8LYG4JLewnxVB/z1djdvASL3q9K5Mmd55JOISx7L6dD2Yr+dQW1RZWQuqmvopmAI5fcyDS8AuWlYP+OqAGggVcCQ2pvo536AdqUH5BzMzlO/FwHO5NhQOL0ewLptSzbMvDXMMIpoFUnMwgCVyDtYR/zJIvCJ7TCunvhY/53I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804187; c=relaxed/simple;
	bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiqqvRHW83ZSH0/gr2AScAxMMW7sbWvwisODwxaMq+oiU4kR0D5cp6vXQXPm2dd5Ln1kU2VCDG8joD1sjL8zpNesSkYHSR1zVHtrqRup9hXzQ2ouqUGtIu0Clkf5NlbhN3uDpmap5R17ieVMDSqqzOfMF6qYtCFYUCCx2OT94gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4o6mDays; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-503347e8715so27732911cf.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804185; cv=none;
        d=google.com; s=arc-20240605;
        b=Tgs7w/2c2rmQP1iuACL6YqhAsq1D0tXAPzqFcDfdEdxPHGG+bb0MBN8Vx1IQKbQxi1
         fRY+O8QRw7oIwPYI2etzut6fBkWfw+zxvQEKjqpYZsXM1ih9ijuuYjDOnve8EBz67X4T
         Xq7zCoDiwMimILbv7K6o2f7Wf9tb9Ad17hdr7vXb9YMWDH1k88VcEFhUTuP7nHO9I/Ah
         5IuFsvMZz7OTA/RxC08B/S+9kWXCnu1IFaf5LIiGcPwOScUC1DYutNVv+K/CduvglSNf
         HMHz+w/S95SA2TjaOC4kulbw2WJGIwnQUG61fe1WlkDc7bd2QvQsw4aQRbBgHCWfKz3i
         LWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        fh=GjfM0zd31MNh6rB2s/2xyemEPPrIwOHXzKL6xCUedss=;
        b=UpvaACLQr5yahXg1rXIRNtAhujwR4qfGNPgrD9jj0KahVMeQ/xBAmdGLSC3ANd7xj+
         womyu+gz0yBbohuxMpmHmhTzLcBSipuqUnX46X3y9pyXdRfluFApnc0T08XX89O12mFD
         t5LU92P2YsxhycS+L5CTTF1chlyot3zrf1YLjUB0/x9dN6YgoCOpDHxtiNDkSEv+JJEN
         EjRZafSAODp4YZcLlmtArOkej9fDd7RzcvOZ6NgffGx6VcjbwkzkvcIOyLrSjsIFet2I
         sMGBK1L6uDEcqHe0yHC7d2gg7eUWCSkBvXjcYVsAMnkQLAlFfcvId+TT4B+epHjPPd9H
         EoBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769804185; x=1770408985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        b=4o6mDaysIqKbkOZ0XB+byq/KUkaqd1dfWqeR142VSckik+xgYToDx+6KZ/v/wACNiw
         VA7Uz4cStMY9vcHy5ww+RSzERpw/nftHGcRjZgGbHAuVAOF2LIWP3fBblS9A44ixSvon
         kwcjxta8TIoZrfunOXjq8jyHGDADxsWIPck6TthJXd9RnUQOG1f20BcWvlqau3worOpO
         KVAqduNArbcvuOPvWGE8vPXKzg4jBjYRDrfp2QFtU+w8oBMtIu/DfT1yj8YYt3IUkcX2
         v7lzObpL1g1ef/Pe+hCIlzq/WHRsxgbH5pQYtYlKjwitICLSIgap5yKGC8ZJWazLhcPc
         i4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804185; x=1770408985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0t0nq4izqsf4GvgNU/9Cuo4KWBgcrjRZN6raZ3fmXTQ=;
        b=eismJofg5K+M5vghf9MTIPmFnvyS1XFyQBSoBG+ApdFyS96c5L01iTodC5nYPB+DUk
         B1TOpi9BpRbqEo08DA3VLoHIbKQTi4LLY/150tcvAl1mbGmR3jJwdL8k2qCcrZi53d5T
         628VxcdSFKJtOLaZhXVu3kIzrMVlqZIqzpQwoTrvvuJXTQIkijGuDzVD136Khzgf3ojG
         Gvi16aw0rsbgXHwEKs0sFFMarO4KwHyCL68XTPA6uUVLyf6ul71t+HWeVJ2Tk48Eu79f
         Q3P8naiGE6I8ioxn/LMiV1fCQrWO69CiDGi5sfs+1LH9qfl6WoGFKl6IOgC0DD9720GF
         cifg==
X-Forwarded-Encrypted: i=1; AJvYcCWcJlKvYxo3TM0mJpZQ9BsChEs2DgD0uv8qarKjeV/D8VQfF0WyOhDUNsB7m9SmCqOXS6yN/Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdoQaY3mtKALCKClJ2zm2MmExxhw5xbfN6W+T+v9l/xU4b2Xo
	pNjCcdKV1l5g3QTrU8enQKJNoy7AbX69HJ7jO2BNgA52pZdEgzsFwCIRe2hlZsZmWIPErzHr5s0
	9rHB9PvYa5ZjQ0NGR9RYmLS//Kki5OCloO8Q7gWVt
X-Gm-Gg: AZuq6aLgD607xPNi0Frm3adyZOcplLvfFJoRJWJw15MMcoEgbbVGAzq0NpvDZKaesIA
	OxHDbP/tN6Q65gO3BsoSKMCnGgPr3fAecIt3JrhVHA2SdH1vhllIW/9MGEhB+pACI3ga6yyhW1K
	Kwaj1wX+iDpL/HP18VM1zG/QWRh4cZWqf5KNOGNrRYLz8MXUFOGSPvy3dmFukzfY2yAnaanG4Iz
	dvtXlB1cIpJEeFIKaVmrvX5I91XQDOfekez+qfFT4AaMB3lISRDUlOCKXkWx70+Nb3U9YQ=
X-Received: by 2002:ac8:5754:0:b0:501:4420:62d1 with SMTP id
 d75a77b69052e-505d226f589mr60062871cf.48.1769804182889; Fri, 30 Jan 2026
 12:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org> <20260130-net-next-mptcp-splice-v2-1-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-1-31332ba70d7f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:16:11 +0100
X-Gm-Features: AZwV_QhPfbD3TZKlMJ_xVQRsXqSJjU6kBe-oa26mxAqnC8KtZaJD8P46JjJ950c
Message-ID: <CANn89iJtTCAj7h2gsAGsu0J5E7KNXtqCgNR5Cp0rJB6ifnMvHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] mptcp: add eat_recv_skb helper
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255248-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CF730BE5A7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch extracts the free skb related code in __mptcp_recvmsg_mskq()
> into a new helper mptcp_eat_recv_skb().
>
> This new helper will be used in the next patch.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

