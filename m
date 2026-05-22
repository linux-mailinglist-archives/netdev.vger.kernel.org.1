Return-Path: <netdev+bounces-290881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC++Du+LEGrEZQYAu9opvQ
	(envelope-from <netdev+bounces-290881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:01:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733D5B7D68
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BF63032644
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9442477E51;
	Fri, 22 May 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSrlmE72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A51A9FBC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468734; cv=pass; b=TWb/qpfT7Eb2qg8N0+aOlxISt3OIZRruWpe9PMj/9vEuih57k3xoCZZrnNB8o89b49b1cDc3P97a5AbUIUKW92uH9L+Dlj6FVISvs+zpiqZ8gi7ORILmt47EUejASGugTSeCAQsMYu/Fxi8j5zLFiLJOq47jngKw1xmOtpbx+Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468734; c=relaxed/simple;
	bh=MHMPfyYEc/OlyLHbYkYejQOZzJ0RlEfSIdCu3FMCfsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3/mstE3MeOFwgFBPSYM8VQbVZd2zduYZbc415laGFPx/nPQtejcHpnWrQL3OwKv3rPSCVDsZDdbCZsPnHkOBtfCATTg4SgM98igkKEHCjhCqp8qGUGSIjrrBjZ6Mpzc3MEgtwfynlPuZKIZS8vDJVVznnUrb0jNr2JkoxGayx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSrlmE72; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914c1ced558so11320585a.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779468732; cv=none;
        d=google.com; s=arc-20240605;
        b=X3weBSkbzKXOxV5dzJRsfYo3NU5qGf5eDRWU+LvRqr0FECBR3Baf4r04UFHMmYG60u
         fUTOTRnNAVqmYDeNlP+ZxkTEFD0v82aARC7F7S1wOPUCek0S1aPX7Yjj5RpXTbinWkIN
         NZ336tm/lH0NX4YQ0BdA5eDN0KCsDgRK6+ML+SVi0d1G4iiYPkJ2TpWEriA45Nm5jNbb
         bfuenRTKEK0ojbs+1Tp4etoIFD1As5Cm0DQ10Gwa8FBAeCI2yTkXRj2gCVLWAbwX9YYR
         KO18VYc04GQcGHFF3cf5MGtrMz5KcvWELQPUdaRFJUGqLvQ1ZKhejR5W6/EtWvmP4WKD
         PeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+pWS6+Ky5BVxhzOlVPEBqwt5jrZerq97HAgKH/NCEKg=;
        fh=MV5keGO0SCBEMukMwxsiEaNKBm0fYuNdMPzbcyzBuEE=;
        b=NHgcwHYK7DnFhFtd10Xgt7uDCNWNPeyBOAcBuD5tSDPEdWwvsreF1v+JZutp9zuJ8z
         tC2jbSpWUbzf0NiXMlK/N14nDhFx5xfPzQvJ7hZIzTbJmM8zIUG1VtzQz8+IURjzmBGK
         TF+GHLK7+ypBkM+gBqYS1flArubib8lhyM88DNMTLz+6EDeebwncrwFjvFN68jJ6jHr9
         JmRKlgFRQbsBcz0Q8UiVc0PpKRwGCQ9n4q8taSj95T25s1mpzE/ahoe3S4XPbu2wHF8M
         LQ+8e4DaMae+7ZF8ijLzPBWTQ02twwS4K3PgOme2Zxt+kchseQW5Ni4PreU6+YnUAH2M
         4ntw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779468732; x=1780073532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pWS6+Ky5BVxhzOlVPEBqwt5jrZerq97HAgKH/NCEKg=;
        b=vSrlmE72dz+V/2BMtvQ1TPTZw0Ihop/t0tic6pJOkcqJL2uwPPWj09/USicWI6oTjK
         sS2H1QTJ33M0qIUh/WByxwGP21XFyxglZgRNBnB93I+mpdGnFNPfi7el/sHPBqIAbTFm
         +C5HduzSqM9fvccBB5MTpf2IZP6YnbjuImSwG6WH6+Rqhugdjmz9Gp7il5vAWr2u2ptp
         699Jb3C7TGqp8+6REqBa98c4x3S/xm29H/KGOSVt/QkzGBkO20HKht6uOXKaodfmoSMh
         gSmN26scPbqHJ7umXxXPZA/HD2mlFsJhe7qBfAV2THRY5UAzik3HnVUolXDb36jXEsNz
         DM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779468732; x=1780073532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pWS6+Ky5BVxhzOlVPEBqwt5jrZerq97HAgKH/NCEKg=;
        b=s0zb9URnn1YJFsqQUULyslIQLCiSsMsMbVN4iWNhDIBEdMeXDrjH1BsjaDlikRfV97
         mJNjxv5VXvNh45BxlgxiZ54j5nr7ZqBGmBGDlZ+MFY0K1N2DEkkvdCL0wRpdZqCeyZZo
         hor+YUkdnyaTNmxHPaxGiyWgMxxp7Rjr+rY1aKMgCBdLRsq81LkzyxjZ+SPhlpXGgPua
         L6blzruPHSHn3WezpBusB19jL4CUEvwzrBUqo7IM0hnSwTQeo/sJTYsj9eOopg6fPq34
         O3jBTP0Hm4y8uuukbL0AhpnkQNw4xMHTmmel2bfEhPoWzzH1CP1+SkihldI1XmrRrMKV
         kw9Q==
X-Forwarded-Encrypted: i=1; AFNElJ871Xag2S00dqK7KVy2ErHzSG7wGVseXvf0Q+0er4pddPa68ut+2+5hZVeVBPAjgW9DPxhPp4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4QKBKnPjSAoPZ5H0vFmybkZ2pIf8s8G00xXeFbK16lc7bcMK
	JUyRfd61vsEjt+8I4q9vU0TURzxna9AyEtVXsnQ7vMcpeQOqY143lfz2TMLrdaHJE15WGsiqMRg
	BV3Ox72z+vrLKn4aDh4jPy2K5aKzs/9ExwAL7/V5nFoaRenBw/VOFIB08
X-Gm-Gg: Acq92OEVDxKnlw1Ei4UL7b8eE59EhZXbRP5V6rDS+JkL95H1mrYhi1s1FSJ6wXFURnu
	uiwwLFBj/UgP5++UL6JeD4Qtx7QA+TvRpCVSl5kfUkM1LPUz7H3nOQJsff6t2/sYrzhxJlzfvB4
	WPbyM4yvUYgCP5pZL6XOBF6MGYJsnNM1oKetFmtblYtDgygKaobXYzb6MydmepEid7i06VLdxG9
	/oHpec7EuHQJ3ylubjD7iI5k6C9uBvK754zQIg+9C3JIdZ6V7oEFOuJXBnuJFRS850akeQOiA51
	ihYh+H1uGimrkLRerJmYeINfDL0+4BRB8Xx2LoYGbsRtYv4dcYabIoz08l5dI/MrEQM82ilJpa9
	DRhhq7j6l5x7IBlSYpUwkR5i/KXDEI61LE/MxrRY/G1Qv5VLLNj962T4Ouun999M=
X-Received: by 2002:a05:620a:2408:20b0:914:ba7d:160c with SMTP id
 af79cd13be357-914ba7d17c8mr292203485a.35.1779468731759; Fri, 22 May 2026
 09:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com>
In-Reply-To: <20260520103227.1133277-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 09:52:00 -0700
X-Gm-Features: AVHnY4JnL93zKXTuxnljqSQlzNmhcCXliyzcoCzmKpFJrbCLwOd5hgnK9JlmMfM
Message-ID: <CANn89i+SyMTuiLr7NDqoJamkgAagWHNRZYjffjQ3Qdp9Ef8A1w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/3] rtnetlink: RTNL avoidance in rtnl_getlink()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-290881-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4733D5B7D68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Many shell scripts invoke iproute2 commands specifying a device by
> its name.
>
> This series improves their performance avoiding RTNL acquisition
> for their (repeated) name->index conversion.
>
> v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)
>
> Eric Dumazet (3):
>   rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
>   net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
>   rtnetlink: do not acquire RTNL for RTM_GETLINK with
>     RTEXT_FILTER_NAME_ONLY

I will send a v4 addressing Sashiko's feedback.

pw-bot: cr

