Return-Path: <netdev+bounces-285986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMDzMZ5c/mkWpgAAu9opvQ
	(envelope-from <netdev+bounces-285986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F84FC18F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8483F301A3BF
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56933ADAE;
	Fri,  8 May 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrnVB6PQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69283385B9
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277529; cv=pass; b=KPdHY2XceR6tW9o1WF0o1vBwX8rnsO8eWKHMU3CTaDKIl2v4tn88eP6vmuK/F+0vRhVnf3ZvtjkEH/EQezonmATfddRbwLQnmUz4zt8rjKbWmW9Lm9k158FtFMQ5vMB572x0I1v9bXPlp+P7dSKY2dODKZruaP8AKbkrWprzTKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277529; c=relaxed/simple;
	bh=LlUMof/dbU2rlaREyvSYkoJRtq0NO13kmDTQ1RVYUAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHrs/MAgEFOH9OSj1wGEusRZcMMj7OPMblJ9906dDCrmUZHB8tttY5GmswnATpxA5bet+x+pVS1XbWMmnonbmJYPxCEbL4WgzBZZ7owfJ4DBk8v7Z3Xel2qjCnIWr1Of2W5f6bjcgV3zbXSArChlWbw4rFdAIPqhOBM7C6WOkdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrnVB6PQ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dca45ca21so3749248c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 14:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778277527; cv=none;
        d=google.com; s=arc-20240605;
        b=k1A91ShqqVF3WM5d6oc4kdsgqR1mLo6+9fG09BxoeL7eDk90c0vXiB/fF+4aTsB/sf
         O9IvTDbRzracN6FsvWVe0XmdUJCdCuKMNpirAiqpJmHsBMqCniZuEgep6xTXCRbYm++B
         Utejz8WDBMfj6miSw0ypTPWnPKvqomQ/FyBaBoL3CTta/mRAkWAN6wmxrlg8tfAONri/
         wCGlfzvHp302nGK2Efha6oRCVhHzkdcYMMy/BJKND130R7d4ShlJ04nbp9jSjO3JDbsc
         2NXHXNL8hyUMJAY+MQQ6s2zoZ1tgGt2StqoPvf0PzpuzjjCvUxrr3eCoKb7zSO0/4op5
         eWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        fh=EaUKeRGzsSh2N9jyzsWD4U4orytO3noODmsNPEaZzps=;
        b=DAofTY/0YQiu8+FXLGlHvWCbkTA8tHTnkGPevQWSbWsVEc2lfVA3lUbwrqpA+q0WJb
         nQhiVSPazSkpa1v2Zy960fBfhdjYFxAZK2N8/XQQObJ58oDkzs8ju3dl8s5H0zM+hfGh
         cEITRSrSDDlps+sQpMjoDsV11/cAEBu+ppftbJdzdLfVuGLRCTy4uf9a/UJhF/TlD7dS
         FxhYiQ1CD4UsjWU5sCtKUZBfEs9LoloGLFJ3eHoN/pGTYKi0SGCgKoC+pAx2b9BV+Adb
         wMwWj98gwqXE3i1/jQXFWeEJr38O1wqUk0HAuKoAA8xKdA1pdoz6gihWQam6n3LTMJpp
         1uAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778277527; x=1778882327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        b=HrnVB6PQhiDdOT3CWFFAYT9GyCBj4JfA+LRw/3k62qxeXgwu8OHcNyL8cEC2dRa7Ih
         hvHntW0A8GLLSjrKK+ijQr+r6idS/KQ6Hf/Hv+hVyQZP1hd6eI+5lubJPxHs6KMhbvNX
         2Elw/ipilOf59vQf7Qlemdyblfcq3cS6qDZoIAH0VHjCEsk0jzVGk5rYhoTrsBqv1SsW
         7gyXVk+nudl1/7IpyCEKuuL2X6bAC+tTlb6osEo2jc8wzxf4ckWqXDkKy4rIyw8m5fkX
         S1tMVVA5NhC22vPdht8K14U8TZT3OrYV7iVuMoYF6vxbuTRkV+Umg8xFuz0E6bRqQFqG
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778277527; x=1778882327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        b=CwaUU0FoYMGcba5kznwZk3tJGHdB4P1kUr4JcMW9rHvndbfQSWIaBOL+wvPhcDnD4b
         9Hqk9/jr+vjzt1ffZfIuiY02/mOjn5nKhV9/2859T+UnL8DqrTy6AZYA2PfgZ2Ju/Tal
         8lSXftrnHVNgZoufbIo8S+B8VkU1lm6bNJEz+TIbL5sjQDXbiTx/tSjSmdHPYLF9SSXa
         JqW5HiCwxSH8vxy4uqyVzDooLU8xYZRc0BRuiiP3JZxcIk8POQYtb4JfZzro5yxXQulm
         EMAIMOiVTN/+B35plEXy+F9H81A71YVAcBKn9HW7kzzi5Leu6gq+gYWYV6BQvfYuknc8
         qkew==
X-Forwarded-Encrypted: i=1; AFNElJ9SPQLihK9w0D9tp0uTVMBqfwqtnk1BpTiXlN/ATCPuy3o90cBjFEUmVtkV0tbCfzEySgy6LRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UDloAbC34aTMVcKWUoTzQi1txPViQ4rTBN43RAzWmP2E41CF
	IEN0aQ97s/hWIfw6dVrRcTDJ8Fq+0+bVSMuRhk3ImsNKjBwaGYrjLwCzcAlZvVENNaLyKwi63cg
	kgIb3WaxQ8TpnrNrYgVThAxyddaFiY5Ts7xdd4JHW
X-Gm-Gg: AeBDieuFOKYl9vCOwa7qBe/ShlZ1QNf6HciKfl5qaZr4Xyeb0/vmzHW6sfPUQzwK3lP
	XxF+SN6x1yWKn9qxb1nU3Ilw7WRY8Utoi7fCBeGEubQLURIsKVJf1XoBPJ7b6by28K50wwmbaXQ
	JCGyZKcPseyYPMunrnMg3EeEte5lDXQcpneFJnk+M/f1m2wJDAO3zxcSaktvQQj9gLvqpbQvnvc
	rJR8oiN4UoDXjlUMEXAIOYS681lYBv8QSdZMvtyVMpje2kFf8qTqxURljq8GGMTPoi3fvRI+9yg
	9xb4Ds28pQNaBgWLbfS6f/N18/jlAwYVR30NM8JoN5kSMfxMA67SS99ge+H+rOJgN7KBWF72hyr
	St8CMzwLZ5UxpOJPVNzdkx9YR4Mkyyrw=
X-Received: by 2002:a05:7022:1b0e:b0:128:cf80:deea with SMTP id
 a92af1059eb24-131852d9708mr7084962c88.1.1778277526384; Fri, 08 May 2026
 14:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com> <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
 <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
In-Reply-To: <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 14:58:35 -0700
X-Gm-Features: AVHnY4I8jhJGWGTWCJQahgL6Wj9Av-IrNZFzkTICY9gL11rTPBov4fzzUheCl_k
Message-ID: <CAAVpQUBE1g6rb_ZuuJJuq1N5whQzxoh5bR+MPC=9-TU0JYo-Hg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 320F84FC18F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285986-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:48=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > On Fri, May 8, 2026 at 8:35=E2=80=AFAM Stanislav Fomichev <sdf.kernel@g=
mail.com> wrote:
> > >
> > > On 05/08, Kuniyuki Iwashima wrote:
> > > > The test is roughly divided into two stages, and the sequence
> > > > is as follows:
> > > >
> > > >   I) Setup
> > > >
> > > >     1. Attach two BPF programs to a cgroup
> > > >     2. Establish a TCP connection (@client <-> @child) within the c=
group
> > > >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> > > >
> > > >  II) RPC frame exchange in various patterns
> > > >
> > > >     4. Send a partial RPC descriptor from @client to @child
> > > >     5. Verify that epoll does NOT wake up @child
> > > >     6. Send the remaining data of the RPC frame
> > > >     7. Verify that epoll finally wakes up @child
> > > >
> > > > During setup, two BPF programs are attached to simulate
> > > > a real-world scenario; one is SOCK_OPS and the other is
> > > > CGROUP_SOCKOPT.
> > > >
> > > > While the SOCK_OPS prog handles the dynamic adjustment of
> > > > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > > > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > > > pseudo options:
> > > >
> > > >   #define SOL_BPF               0xdeadbeef
> > > >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> > > >
> > > >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int)=
);
> > >
> > > Hmm, so you do want to have this enable-on-a-per-socket use case.. Th=
en what
> > > happens to the skbs already sitting in the rx queue by the time
> > > we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missi=
ng
> > > something?
> >
> > If the upper protocol is designed that way, it could be racy.
> >
> > For example, HTTP2 could have multiple streams within the
> > same TCP connection while only one stream can be upgraded.
> > But this use case simply does not work with a single
> > sk->sk_rcvlowat in the first place.
> >
> > This feature implicitly assumes a single stream per connection.
> >
> > In our original implementation, it traversed all (technically
> > up to 100) skbs in the queue and parse them like psock.
> >
> > But this will be unnecessary if the server drains the queue
> > properly before enabling the feature.
> >
> > If needed, we could return -EBUSY when the queue is not
> > empty.  It's always under lock_sock() or bh_lock_sock().
>
> But even for a single stream it's racy, no? Suppose I do recvmsg()
> and then setsockopt(BPF_TCP_AUTOLOWAT, 1). There is a window of time
> between recvmsg() and setsockopt() where we can receive a packet?
> Or you're saying that if it is an-RPC type protocol, the receiver
> explicitly signals to the sender that it's ready to receive (by sending
> it an RPC request).

Right, we can assume the client stops at a certain point
in practical use cases (HTTP 200 for Upgrade:, RPC
auth response, etc).


> If that's the case, let's explicitly explain this
> somewhere?

Sure, will add that.

