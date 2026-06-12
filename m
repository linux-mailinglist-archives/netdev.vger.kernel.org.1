Return-Path: <netdev+bounces-298772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id If3bAF1TLGq3PQQAu9opvQ
	(envelope-from <netdev+bounces-298772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:43:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA367BD24
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FNqgjgKD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298772-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298772-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CCA305D5C5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70639A808;
	Fri, 12 Jun 2026 18:43:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84B36AB54
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:43:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289814; cv=pass; b=D0bd7YelB/GW/yoT+HDZW9OmR0FL/FtZYS48YLU9+Gmmm9zJV4EvTnKJn+U8K++7LBn8U6PTqJOToqH9Udv6HOdEwOFWQOjTtqq+v/JBOCp6oMZL4Go6siY9rNH8pmYD6hK1WmSnfFH3xpzmN6UxydpNacygmmp/GbvSUm3xByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289814; c=relaxed/simple;
	bh=IQZpujVP87VTdmXVxfTNfi9J/0IXL9EHLyAaVdEbWQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFuhstzYZB4USi+Gf3pnbeVyZuVppcu5NPWvX03j2Bn72WcQe59nS6Akd2ocXHSOPV8AkwAsHvAg4ivO+hYAE5aHiCz613+rwKoH9hJ3gdcv3J0c5FSBFU5ryXQHXS8g02cQoGquvRvTG3TEgjbYuCkAi4DZ68/uuzq+rJww1ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNqgjgKD; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-138501f8c04so379168c88.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289812; cv=none;
        d=google.com; s=arc-20240605;
        b=GohzJx3AyyYyuNBzdRxukVidK9TFxF/b8PlvRcDKh/pjEf30o2gyI1WFq1uyI3hepI
         fZJ/Da0MIU5wpqw028GjVU+Y0qZx7Quj6wObnuhrv1LOIZLJlVcClEEAaE9kNHx0nik2
         4/VbMDDhkdIEfaElDRQ2onSMKQf96548DfOw1+hsk25CRrrravSFE6PTQDx5kjDytytK
         YOtnlw7F6qGl6XxqWXUhptocyo064YbALBrMiZW9OhL5oV6dfdG5nWaDLHlCSr4A8eKz
         3Wb494tUZXDSJp+eW5pR91AfpgggsgoJGZhPDTZKmCGKBPM34441NjKcBtUGlPmQ38Tv
         dygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        fh=ggOFPVRS71qTMvHyRNpje76EuRrePJ811oJMUzA7xzo=;
        b=TBuJ4bsqwrvPM+kUGFxIZLC/gpDo+mEC8TkWWFWXZDeG2fvYGCaoXlUjXdiLgzrZIp
         78WIs30vbsfIcbxgLuFvby5ECi6IXDocPts16yy5vWgC8BJmb8iHTzFqIL3ACNLNYhCN
         wqZgXNNaRpfD0xmpGlWPdNmxN+HoEF5tJR/G5+yjI+quA+sIfDLWh9iPsQOE29RSCMyH
         C5iWG0n9t5r8PKiuwJM1O+bp77GeOcenZE3wBZgbyYDaW7bZzwjraPVIB0J7tjJl12nC
         CvNUf7qojYUl9kEeYJeIP60MksZZlkeZYktwxeBWHipRMPDozpvzfgSc1D6y73jimv1O
         3a2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781289812; x=1781894612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        b=FNqgjgKDckM/ef/CMXnPTNMN1jfEk8s4gs8f9SetKVyxbd+n4K1AEEwZ3OYV0H9yw4
         TndiQagpsw9Dv0OpqPJmlWl/X2s99mp5geH0oRQ5iP5EWzQbOgGz1/OmDiNiRxXKEqLg
         PthTVFY+8Zzjbo3qsNgag8YlB9qYdkUToYF5pC4fTCsnpQZNIT/38ySyjf4F+HbiFg+j
         eFNaOxY7BZnmnuXq2mqSLvVgyERmOmN5pmLO8lgUad0/tjRIBIN2N6LgM7+el73WXaS0
         dlu5/OuXV50SmD3cWcZzGLqXCgD4lKqGiYuSS/HbmTtMIjARhWiMh4+a9NrxSxm+LeFy
         LH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289812; x=1781894612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        b=YLaCxCcpH3Cy7TxhrdhFr/lyMV+lQAWA7Q4i0Esx4r+9tnNSwtaFUtOSYZSaNBFUeq
         gUoCJ/Lny01F9l8sHRrfJXOyjlr76okMGPOackFLqUpj4sERSL1ypcZX1RTyvgEv1ewM
         hqtqhdCeFj4jgYo1NnwsySrR5sCsLqub8zYXhdn9JUmM+Jjn6vcKGEhIrPC72ASrtpiO
         by+DjW4Rzz0tuOPNSdoQ+yhK7+rPJOku84d/FFatNUdfnfNWNnLA7JjncHxEj79LXAUG
         5lq/x5skdOU3qpuE3mTR6vqN7WpktOg4T/gtXScHVa6z28h3eMvveU7sg0H8xafJJlQH
         vRWg==
X-Forwarded-Encrypted: i=1; AFNElJ99OVcjLO8x879tqPBnE98kYtMvDLmmf6C2seKIeCiCPbsWIHucEUaQXsia6sQcQkT04fMJ3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sorszuOgRwnjJxy+z9ZGGAZxrrEF2VKfa+EJrFsgYmYSwBwo
	5327NTgjI29joAEY6B7//05REdGtKYz6es4LtwAU74Sbpl2jtYWxZRuCPcwLYTVWb3H1VVmOchQ
	kb+XymkZMVfo5MhtAIIPOBBs3Mcd3E6Kt3YPKrZBW
X-Gm-Gg: Acq92OFfqyq4M+1QOpyoOpyh8ZeL4k3cBOWABX5sJ17wYUiGbVGRLFOH4rHLtFY6Igw
	WKVk1JrqHK016s06CZnfhQGzzR2UQPlHhqNEcVbLzq1K6nx8pYM2Ndh7BpnEMeBUcJWK0Uf1h+P
	v6qD1tcZibFWATDpwGTVTL/fUKYP4qV8MzE1XGJ2nSSrQP4eW4/h7TE8vLiPGVBxJ9oIqBbvewP
	MMNVKhkqkExMw4cJhkPJofJllrOpJWlNdIvbGh2edbaC51/awcHIEwXGjybrORVu9LzcZRv92PC
	c3ptEt3+Pe4+LJalX0a9a1J8wZM1tC7dCjZ7ZWVeNGSImX4vmNyzxPDZURgJW6cHvGfBYxLOWKq
	ccvV88EcRDaLgYqmhaZBkBdZLJyJB4ukRRMA4mv2ITCtEE6zt+x/7
X-Received: by 2002:a05:7022:418:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-1386f24121cmr436470c88.6.1781289811262; Fri, 12 Jun 2026
 11:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612130919.299124-1-jiayuan.chen@linux.dev> <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
In-Reply-To: <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 11:43:17 -0700
X-Gm-Features: AVVi8CfZ2Yztrdd9Cz0a8Cioo193fVEec7AtKDsitODSamBkyRtcTNl8C85ikBY
Message-ID: <CAAVpQUBmiyfW-3FjssDUmbOXyA+QbsFyATEs2D38ZbWfpNQE+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] bpf, skmsg: some fixes for skmsg
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Shuah Khan <shuah@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jiayuan.chen@linux.dev,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:rhkrqnwk98@gmail.com,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298772-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,vger.kernel.org,kernel.org,iogearbox.net,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96BA367BD24

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 12, 2026 at 6:09=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >
> >
> > All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
> > Kuniyuki and Sechang Lim, which have already been reviewed by me and Jo=
hn and Jakub.
> >
> > https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.=
com/
> > https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
> >
> > The automated reviewer (sashiko) may still flag a few other potential
> > issues on top of this series. After looking into them, they are either
> > already covered by the patches here, or only reachable under very narro=
w
> > conditions that require a specially crafted BPF program and an unusual
> > sk_msg ring state, so they are not practical to trigger and are left ou=
t
> > of this series. I'm collecting these fixes together because the same
> > problems have been re-sent many times in slightly different forms, and =
I
> > hope this series can be prioritized for merging so the duplicates can
> > finally settle. With so many AI-generated patches floating around for
> > these spots, leaving them unmerged just keeps wasting maintainer review
> > cycles on the same issues.
> >
> >
> > v2->v3: Target to bpf-next and carry Emil's reviewed-by tag.
> >         Reverse xmas tree style is used suggested by Cong.
> >         (not all code match reverse xmas tree due to variable dependenc=
y)
> > v1->v2: fix problem when fix the conflict.
> >
>
> Kuniyuki,
>
> one patch is yours. thanks.
> Please help review the rest.

Sure, will look into it.

Thanks

