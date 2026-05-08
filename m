Return-Path: <netdev+bounces-286049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG16FaFy/mmjqwAAu9opvQ
	(envelope-from <netdev+bounces-286049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC664FCC4F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F06F2300C3B8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B235CB87;
	Fri,  8 May 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZmKyuEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E5363C5B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283161; cv=none; b=L+RPfcNmNXPqP8KOkobCneJTle2tJpIS8b4KrKUVzEEvuyI1m306sWWr9ace6zq9IlJOlNQY+53odmcdQ4CXnd8cnz8g5TUuOCpGI78Yd1HcDs9dTpXcfuk2DR8KepGLuKe7CTrSEATy+3+dC1r0SWeuNCCY7YAl+79g6x/VLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283161; c=relaxed/simple;
	bh=0I+fkCToHqIr2+f+LzKA2vRDbcF4Rd9EbtdBi7pBXfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOa6G9L6vrpVhseWPRUnKiiaY+YMYuAoJhDwa5KNQiXKrLIbk6g5seS6tEiGiBCHHJBchrCDsDfYttxY4RlT+yjt7yZFKJ8dvhiCw3i2YEXhISvyhyggT3fqM+RIhMNJ51pahgqiyjFcyvnb6LtrOBx4+730IHpWpgP6WwQyHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZmKyuEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0146C2BCB4
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283160;
	bh=0I+fkCToHqIr2+f+LzKA2vRDbcF4Rd9EbtdBi7pBXfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dZmKyuElmGuyA/3oDvQmz9EgAMkjUutPOWdSs/N00pzwJNud4fB5ObIY58lGJq1u6
	 5gM8YdFGpZx0646Zuk6CqiAZUyZruUWM03a6njDnKP7UyyppVoyXTbnXbvQsreEqJP
	 Ykw5xyHeaTZMKtsOCLYqU1rjKag8p2M6rWP19k65IuFUZDdu9GUonIuKkQk8YmqX5U
	 lyz3horAL8j+TJB1YOffh8A3Lz67PBZ8P9h5aKoknJCK5RzZke+cUv1kqn5ea75m+X
	 dnRziY2c64d01qaQKCWItXTyGsnwI0dh4ws4yHqB3h20ZvxhaXr4YDC0kxx6tEJjXw
	 RMSUtLSxDbtrQ==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso22387116d6.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 16:32:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+N3cp4vHYUIq5S8bNq+xNomVW9OShu1LddLd3bLnWij8B4UZ1uSEoSdt+66Qm3mAgT7UMSua0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOfdhBhA/maNtJMPLAbIMKuo50H00cxLUwg6CbxIOlNE+8TlY
	R2eEsRDzwt0osbYq6QfE8BHX+rn2OVVLMmbSGTwPDv4ZRTwSNfkhoz05EF8P8bIRbu2i8YiEmRo
	psrEQ/om6bNyhWxNKHLvIKBHvOXTvOUA=
X-Received: by 2002:a05:6214:458a:b0:8ac:7e8d:8599 with SMTP id
 6a1803df08f44-8bc43338135mr216982416d6.20.1778283160040; Fri, 08 May 2026
 16:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108010728.207536-1-houtao@huaweicloud.com>
 <20250108010728.207536-2-houtao@huaweicloud.com> <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
In-Reply-To: <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 9 May 2026 01:32:28 +0200
X-Gmail-Original-Message-ID: <CAPhsuW7YYRD-AbJvhFEMyEGgui6Hxoasuhp7Bm1OdxP0iLNgFw@mail.gmail.com>
X-Gm-Features: AVHnY4IYVrKN3_F6Ka1qodmDkhDqpOTHVwYgQvENWBogWoZ-8iNupslAgfu9_Sw
Message-ID: <CAPhsuW7YYRD-AbJvhFEMyEGgui6Hxoasuhp7Bm1OdxP0iLNgFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/16] bpf: Remove migrate_{disable|enable}
 from LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5BC664FCC4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286049-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,gmail.com,kernel.org,google.com,iogearbox.net,fomichev.me,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.170];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:33=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jan 7, 2025 at 4:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
> >
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Both bpf program and bpf syscall may invoke ->update or ->delete
> > operation for LPM trie. For bpf program, its running context has alread=
y
> > disabled migration explicitly through (migrate_disable()) or implicitly
> > through (preempt_disable() or disable irq). For bpf syscall, the
> > migration is disabled through the use of bpf_disable_instrumentation()
> > before invoking the corresponding map operation callback.
> >
> > Therefore, it is safe to remove the migrate_{disable|enable){} pair fro=
m
> > LPM trie.
>
> We got some ENOMEM from bpf_map_update_batch() on LPM_TRIE.
> I suspect, this is the trigger, as we are missing
> bpf_disable_instrumentation() in bpf_map_do_batch(). IOW, I think we
> need something like the following.

Please ignore this... I misread the code.

Sorry for the noise.
Song

