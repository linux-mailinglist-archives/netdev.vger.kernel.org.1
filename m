Return-Path: <netdev+bounces-252204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JT2Mx+ncWmjKwAAu9opvQ
	(envelope-from <netdev+bounces-252204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813961B49
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FD57401BEA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF642E01E;
	Thu, 22 Jan 2026 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zQy/Dm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD438FEEC
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055713; cv=pass; b=Kx2UcYmCPq9V1BklkbTx+/WSMN4IZ14zeL7x40ZlgEH1wOQwyQ4LC/nL/fzIl3Gg2riXkFMbM0+fIyLj5unNNDwbLITDx4Gi3abxEV9lP7f2kVuAgsb5HeWdvcNlr9jrF33zGe0DCYrPGT+zWv0K9ZHenoILo/2elPX1vu9qKQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055713; c=relaxed/simple;
	bh=mH5awB6ralgR77aSnZe5QraaBsnwcsK7oANg9mkpPlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d74uK69WzA/TVODUw4KCiKXl7ECQwR/FlraSISP5yxo5RQUpRSwTXHjJ7S0OEVeVXa48z8CeamvJy+QTa0b2gtyyZ3FRHLr6jtzJVYHcM9QaLzuezvnheUfs3IuLSjCEecsSXYpJ/NqDvNEGi1MgcHTA3mfDojF9nlalpTJOu7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zQy/Dm8; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59ddb20b720so1523e87.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:21:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769055709; cv=none;
        d=google.com; s=arc-20240605;
        b=LJM3E5fhZkys/c38+EcEA50wqQoHU92nGke6KULp44riF7ZxoE9/F8beduK8wQOVZs
         DtBKzxJANnUH3JuZSbYGkFeb05tcrAXMP1LuxMJ3dTwS3FipmUcu5CKMK2g5WRIBY5Yg
         Ia/HPG7yoBwo2efFcYyvyxx69s2CXywV2L57nh/qcbslB6bMKxrdnW2xWav96oJcUwZQ
         7znuUVnMtoThRXlRW8yxUP5Xjy1vuvzKf1aG3n8Vkns06x/xknGliHBLqqf7cTnDTtXv
         aionqlZJjOIfCZ6mSgYue4JwypMsLZRLr0JC97YhAtl3ccVplziDN4m4vPe6dq0hqwYu
         MgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        fh=vdH2tNBpjADRlGcneXBfBVZbu9sCxkUKOYxkjdieaYU=;
        b=GpyURHFUdOQ8WGlDjOIHaLPcz5cX4i6MVyCbjhAZSmKUJat2nsG8C+GSXsjpFwxCDh
         pXoiAwFSb1HbrcJrHbzYijAGDkToz+7HSosJaecKGe3QNUe7BPILyd7XK3WXuBQSpAHv
         slExETFAtq9FIi/elvmUc8tdI8f+VRQtvjuocryZ599899xisKYogKhuMKB8yAeJ4LMv
         e/VgPY6x6+KKL62OiBuioGzO859vsbq66z1R8vqI+RaKUM77eW+o2KvsLC1BpgfHf+1G
         zEcptgqNPo8H7/j1zptjDeEKa5nWMfebIvbCAi33Z8WrLqIHYOi2/8orqRMMF7kUHwVd
         Ch7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769055709; x=1769660509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        b=0zQy/Dm8TcfK/iDLejdkGKUQOOP3jWZ7ooOgqQrJPCLTZPZAkZopKiYUKC/C7+yYyy
         ClAhXuIspjsgDJdrLUXWIvf5fU7cM8RNVLOHF4xa7pcqUFVXjYw5SU5+puHobJPif2aO
         PZ1Q3cGElKY0o9+bhHRNBXB+DMSyGFS3NrchUlN5JJnv8ETEb2TMUSzEhZQKvq3ctDeu
         fRPG6U+awhPadcCc2e79h1fOQ5Thak56rWPGd+9eDu55QW/EV7hYDrPWCEr77D3zPnkl
         xZ40KACcgE0khhhG8tdoQsHlmlcUL0VhwcpZHXQz0PMbivuHp5E0UL1P1LoIVBW9MZuS
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769055709; x=1769660509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        b=mmnfXUXkKPFsZauyTdKkTGw38yL4drbzKYjwEUMOxwzRftR8a1Qph3yYpzkeBq5BlE
         guGIsVnhwqC/5QmyUKgIv/9IKuzVebVvfkiTDDk4YG0PJtk2UrrnTxGn6f+mEqcZWqr4
         3bIl5V/QPlJNWv01OuChBoYdm9kSjIxberkoT7xal6T7/mOIO0PhX5gB0o7tuYHZk5/a
         +u3eTyV6HB/xwLRPtdQBne2Pc1euXm8IFjlp0YkGZK7iaZmTQ6a29f0rWexw+DKHdC7W
         rXzrPcdDO+LQch+gfeoJhohtkIoqCDoNch48b4gxRQ4eYQApR4vUMeItxDDochp5JyrR
         u7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsYtVuqFsI83olnWMyoBhK+fBZP29ItqAHleUixvf4mDyBzvv1P6aQlYwZTsMX0p3xZ2oitic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXdUJjyPfOwaRArdHo5dMa0Q8cqbtgJcw7ACPVSSVBj7ZXhdY
	vP6BfM9fdJngZMYQjYuq6XToRy28wvdbqd+TqcKg+0V39ZseJyv0S+Anc+ZohB/VHTlJaLJtsMV
	0SJeE0BQ00pIsSgTB35NYa38ADHtwESOjzZJOdxO1
X-Gm-Gg: AZuq6aIwVhvFACu0ekTQ2qvjb0bkSJWhGODwJaCpSLaBs3QfFoybE0Lc2mpqhISUq0r
	ObFJK50nCH5ArdfiIIW4kxYEcu7EmShItl42w9M7ES+jnOBmWuQAGzGB/L+2w/8r4EAxGcc3ZG5
	AS1lxC13UmAyGKNaBdPiznLSEU6E2rgxyEhgZn6ODeMZbJE+Xi6MsOmZAawhLLjc/3rRygYJlDI
	fVEsZF53HLUczdhCAwh4cRJLNMRf/UrtVQy27b8OW1ey3gPL4ROMVSaJJmRVCi+9HJgzfI=
X-Received: by 2002:a19:f009:0:b0:595:8927:8a32 with SMTP id
 2adb3069b0e04-59dd9e0ac3dmr85586e87.16.1769055708809; Wed, 21 Jan 2026
 20:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
In-Reply-To: <20260120170749.101e8bcc@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Jan 2026 20:21:36 -0800
X-Gm-Features: AZwV_QgK7aDkPrzxUeGdcAMqS5gjfqbpQkTe0opAcE2mJCNB7DPzAw0bMRr6cbI
Message-ID: <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7813961B49
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 5:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Jan 2026 21:02:11 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding nio=
v
> > array and a uref field in niov.
> >
> > Improvement is ~13% cpu util per RX user thread.
> >
> > Using kperf, the following results were observed:
> >
> > Before:
> >       Average RX worker idle %: 13.13, flows 4, test runs 11
> > After:
> >       Average RX worker idle %: 26.32, flows 4, test runs 11
> >
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> >
> > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > optimization on).
>
> IDK if the cmsg approach is still right for this flow TBH.
> IIRC when Stan talked about this a while back we were considering doing
> this via Netlink. Anything that proves that the user owns the binding
> would work. IIUC the TCP socket in this design just proves that socket
> has received a token from a given binding right?

Doesn't 'doing this via netlink' imply it's a control path operation
that acquires rtnl_lock or netdev_lock or some heavy lock expecting
you to do some config change? Returning tokens is a data-path
operation, IIRC we don't even lock the socket to do it in the
setsockopt.

Is there precedent/path to doing fast data-path operations via netlink?

There may be value in not biting more than we can chew in one series.
Maybe an alternative non-setsockopt dontneeding scheme should be its
own patch series.

--=20
Thanks,
Mina

