Return-Path: <netdev+bounces-253737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FjJJJ0NreGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E443490C2B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541533017C17
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548430AAAF;
	Tue, 27 Jan 2026 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6c2zMuW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EF278E63
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499456; cv=pass; b=WUH7FT9/rC5jG2RVgkDTt5ChtGGgLu8egzVI54OjM/dll6b9+NMwKUDtXh/Ugx7nr/O88o3rynP4OCNegiS3ks4BImq9LDPjKqCIMH8IZBZgxh3J0Ilinr+mtohw598cermtyB7UEiJiWkg2ZldXg8xtnQxMA3tURSeQp8S4itw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499456; c=relaxed/simple;
	bh=3hOQnMWoa6NN3hcX5GZiSqa8OS8vWvHzRUzfB4or90U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rM7JR5VvtSsi1YV157Geixf4C0Lh8d712umiE7y8GXnpqdsLW8Wgq1fybs14tH7WvH+AyCpaWfnCaFuEquALF6jWCmELkr1vAIFuhwGpDP/ViRFYIEj9dmnPwjGT6DcPbwM6GH625kUr0LGMfNlHR6H88rhzuDQzC1NIMpU+QTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6c2zMuW; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014b7de222so64761171cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769499454; cv=none;
        d=google.com; s=arc-20240605;
        b=OL4dYfpMz0uMx3BfIHOvPS3iG2QIMfsOApYxu4hnAXX319O2cU8xb0gj3mK6OdoDjh
         1UJhXUx9PHD3D7VzQnWGA3yseOhrka9rguv/vH/RgF1ULuZ5K3CJtRbft6J2lOHHLp6D
         PfTZvjzecyCPxD98ChI5aILobOczRGUhL23eDWxEj1Xy0rSCiu+uFA7uuohhyax9h6Cv
         VQ+MQU3vs3KiJzk662UEZqEgrDogcr+X9nL/ThbTz5o4pXVP5l7gFL8XhvGg9j8rkoLa
         VQMCSXc+N8Q/q0MOQP5UaLBE4uNOsgnZ8IsA9btBzMQyctPipUMOgPB6S5Bs24fNYKgw
         NUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5E6MCGD1AJ1KLpME6qPCKRnV24bPENq5PEOJ2L/Sikw=;
        fh=VK0k3tlLuENaIHmzQi4ai1G3HSpv6fvQ6dUeoJpeYag=;
        b=GWMFBG0dPtWeNy/vfg8Ui0O7ZkAlhkpU9RD+u8AV6tckMV1Bn4DCnANnVWzxN+xm2e
         xBgbvVJqz8vfvdFbBn5gXHmidM1faLmJus3WIboqXNrmho7ivghjUPXM04XKiy4xO6c0
         EjCbte8lemjdf8/ZPpxHVWO62oDRUDduUTfmkJv00fS+bsHh3ol6NgGvr/We0/4MvVNb
         eBIFZAD0yk9BA+F+iF2NtsdiV4vtB/356ucYkjmq7yrqzGHowSpbNPaBArXBK/UpwM0j
         N+6/t7vrkKG9pCUZxdwj5qGpllrNVoFSnLcHXHRig5yVyIM4kEpafjy6K7Z5Y0um8cKM
         FoCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769499454; x=1770104254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E6MCGD1AJ1KLpME6qPCKRnV24bPENq5PEOJ2L/Sikw=;
        b=J6c2zMuWHFKyv1XTtsUYzHkVFYmyLxOd+F+Oi0BzInB1/ZPo5Dfoh7uE0uxvXxRe8t
         fqhHdAa3D3wSuvepWNREoMQHdKAtuSGeHOvGHelmwJe1emoe2qiltcmWGshEbwdQAzzP
         aIPfun4uB3W6gHRCQyCY9gjACd19KwiOq9suEK4s/jIgSJrGDsMKA76LFdV62H61XCfd
         RwMf1iFDvtuW7xXuAaxx1WqgHR+1P5A64J1H5Rd7PuZPkVizedCYtixwaaQMECPUKrp1
         hQBuzLZ8jWBgp+pU7cA8RuNieEtsLV2CyHghTryDdup3C+TGqksV5soUHNDaXLgcf9JK
         bVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769499454; x=1770104254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5E6MCGD1AJ1KLpME6qPCKRnV24bPENq5PEOJ2L/Sikw=;
        b=LjNWDEK7AeF4r7yI8ugDX/SPFmMXH1pbCunxsgez9Jp9Gl0aQYZMhwsZHogn7TiDve
         s6HBQ944ef5GRFuSDGDgGnlz3HV7Kdh2nXnjza6cjwGg9/cEBBR5fJs7ksMbDZhTxWRo
         pR0qW2mNeLcTsFxMVyOvXR0kpqRZ6gRBUo/Oo0lEqeI6FzyAzEXI7ww8XPahdb5TUn1Z
         S+uh4x+Bbvlm9BgJhP6ezZkGV6xy4e1wYhKISVY/D0mEmDfBQqTTCBelS+U9FFoaYUzK
         LKQLTACkS/Im4BOTt/W2Q1HyMJ7urTV+hU6Pj14GfJb/dqY6fTIYHVX04Q7xpAxSj4Zf
         7KTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZzj/unhvgqxesq0NBE20fV//xedY7wNDW2+v1ET+GzE4V4GjIL5EuptSedQzNYZqAGYrPV14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmVg7mXaziChHg+ghZTTsylDcEjOyYjuPNxTsqBebb6qE1ueN
	m6nbKAqbxg4G4NPy44IW8x9hF5wno0+y0PlJuVfQyd7RjHOItp6PRwMNF1OMn5l5Xxm5seMC5Yh
	mmHoJ5YZiXUHbwgPkfB8YZ3iOlhTdkAWYE7jc0H+5
X-Gm-Gg: AZuq6aIhsxqrvp4qDkOk8tQ/S2/ufydY172DNw2plMW2tKxzkQ7Gk8Xx+VajMCaeoLp
	3CtJgXviV9MbWSSLOyZTqKlPC2IuIqboGWjBPNNerb6I/2taw37JJI4R5a2Gf2RqwRVMfsXeotb
	0i+Iqhqyx/zXQGuUsDFsXzwpoPqH2yQ8yliH3UFuHShCRMqcyZ3MVZ2q9OS9Cn8X5VvgBgn9lf+
	PXfdL6ecA6YV7mbA8Rw61PBBfF+RyhaAmAPoOaRfcD+0DpZA1bMeu2E/SCcWyP5j7DJHUw=
X-Received: by 2002:ac8:7f8e:0:b0:4ee:49b8:fb4c with SMTP id
 d75a77b69052e-5032fb1d662mr8488171cf.70.1769499453687; Mon, 26 Jan 2026
 23:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
 <20260123170412.906280-3-skorodumov.dmitry@huawei.com> <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
 <a4a16ead-a534-47e6-8468-58898350415c@huawei.com>
In-Reply-To: <a4a16ead-a534-47e6-8468-58898350415c@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 08:37:21 +0100
X-Gm-Features: AZwV_Qgc7KpPDiZzUI-92VIJg0i_wAT6wVdn_4Z5VJ-QG9HwqpBi9l3z1FQkDoY
Message-ID: <CANn89iLQ2tDcWq-aLe-FhQU2cX8txF5L9SewiB1ssJh+7ds46Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4 validator_event
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,kernel.org,fomichev.me,lunn.ch,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-253737-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: E443490C2B
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 6:56=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
> On 1/26/2026 9:01 PM, Kuniyuki Iwashima wrote:
> > On Fri, Jan 23, 2026 at 9:04=E2=80=AFAM Dmitry Skorodumov <dskr99@gmail=
.com> wrote:
>
> >> +static int ipvlan_addr_validator_event_cb(struct notifier_block *nblo=
ck,
> >> +                                         unsigned long event, void *p=
tr)
> >> +{
> >> +       struct in6_validator_info *i6vi;
> >> +       struct net_device *dev;
> >> +
> >> +       if (nblock =3D=3D &ipvlan_addr4_vtor_notifier_block) {
> >
> > If you check this against the v6 one instead, the if block
> > and the i6vi definition can be guarded with
> > #if IS_ENABLED(CONFIG_IPV6)
>
> Hm... Few months ago, I had a conversation here that convinced me: avoid
> #ifdef whenever possible. They overburden code and reduce readability.
>
> It even might be a good idea to replace wherever possible preprocessor
> checks with runtime checks. Use
> if (IS_ENABLED(CONFIG_IPV6)) { ... }
>
> instead of #if IS_ENABLED(CONFIG_IPV6) ... #endif
>
> --
>
> I'm ok with both approaches (though i tend to like runtime checks) - but
> unsure what is a common practice in bpf-net

What you call runtime checks is in reality the same : C compiler is
able to optimize constant boolean expressions

if (0) {
  code_0;
}

if (0 &&  anything) {
  code_0_1;
}

-> Compiler will completely remove all of this.

