Return-Path: <netdev+bounces-37527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D806F7B5C85
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4165C281B31
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD98820337;
	Mon,  2 Oct 2023 21:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD3200D4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:40:19 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC1BF
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:40:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c724577e1fso2148995ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696282817; x=1696887617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHeMlbjEnaMgFRYvGNL386wIDJayjKLvYUSHX+pBNvU=;
        b=G0qY/9oqvKB+AOSJZkp28nMeAAc1RnUw+cvMAEb0PItMfW5JrmKOAGzFw2BwLNtNrE
         MNu3y603LK3jswq8nq5p4bjYxJO55oV2Gx6GgMZFPTjdFqitesxa1PIhpJKoAvUhTe+a
         mez82ybR6C3O5cW3gpAc6f+BmZWz9jxvupk4PNBh17F4pGt86rKxku//0Y3lNaIVJA1o
         +yfq75gFkpFe4Amdry9l0/IsLDHnELM4wwe8rqPvihLtahjWEMJK/f1kidA5AgM/kwYR
         s1sqvM5xS0jJlOzYMbJYAClUUML9Vc08AHuSzuHb3RsQBWvT8ROr1K8xuvqIHhzpaXex
         KEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696282817; x=1696887617;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHeMlbjEnaMgFRYvGNL386wIDJayjKLvYUSHX+pBNvU=;
        b=q13tvlK0H7hSLna8CAdJU+vJmnU6qyZtqz5XUQ+dg/12R3YqUgcK85AWGwxDXi3bs6
         YBBhzRMQYQFjxax7z3bIW6sBrQbECfgVzinZZ4ZXR5q16/f35wM9qiVPn+dY5TmS7f/y
         6jpGa12u7ygtnH+UXk7qJS5z9QzUJmPty4Pv9I+kCbKo0x6F0O7sD76zzNGrNFKLltNl
         30aKXSOWerhWqYGHVkMe5qa+H6RHKLha09mSWUBRm0DAvyLnzwdgLJBPsl8M7J+irPTX
         cKkQlhmGBpBJuyT/HuifPaWVNK5OUwVUiI9KjQLUv0x3dGfxdvQo4aZftvrBnQriOQi5
         h2ig==
X-Gm-Message-State: AOJu0Yz3/M3OjoJOZFYfXQmR/HF5t920LgNY9v2O262DgKMf3TPzn2J1
	E/1O1toO3CEKV7mn2GITxG0P5qEgJNxGwZIWeKk=
X-Google-Smtp-Source: AGHT+IF/9fHg5nPSIN9fFV4pcxAYiZoxtXJFFl8lgQVlS4uKsIgTPfS0VZPA9Fw15R2Kgc56BCfLlQ==
X-Received: by 2002:a17:902:e54f:b0:1c7:5f03:8562 with SMTP id n15-20020a170902e54f00b001c75f038562mr7624709plf.30.1696282816716;
        Mon, 02 Oct 2023 14:40:16 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001c0bf60ba5csm22378889plt.272.2023.10.02.14.40.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 14:40:16 -0700 (PDT)
Date: Mon, 2 Oct 2023 14:40:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [RFC] iproute2: ipila warning
Message-ID: <20231002144014.40c33922@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Building current code with Debian stable Gcc 12.2.0 see this warning.

    CC       ipila.o
ipila.c: In function =E2=80=98print_ila_locid=E2=80=99:
ipila.c:57:32: warning: =E2=80=98addr=E2=80=99 may be used uninitialized [-=
Wmaybe-uninitialized]
   57 |                 v =3D ntohs(words[i]);
      |                                ^
ipila.c:69:13: note: =E2=80=98addr=E2=80=99 declared here
   69 | static void print_ila_locid(const char *tag, int attr, struct rtatt=
r *tb[])
      |             ^~~~~~~~~~~~~~~

Looks like a Gcc aliasing bug.
Relevant snippets.

static void print_addr64(__u64 addr, char *buff, size_t len)
{
	__u16 *words =3D (__u16 *)&addr;
	__u16 v;
	int i, ret;
	size_t written =3D 0;
	char *sep =3D ":";

	for (i =3D 0; i < 4; i++) {
		v =3D ntohs(words[i]);
...


static void print_ila_locid(const char *tag, int attr, struct rtattr *tb[])
{
	char abuf[256];

	if (tb[attr])
		print_addr64(rta_getattr_u64(tb[attr]),
			     abuf, sizeof(abuf));

One solution would be to use a union.
Other would be to use some variation of no-strict aliasing.

--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -47,14 +47,17 @@ static int genl_family =3D -1;
=20
 static void print_addr64(__u64 addr, char *buff, size_t len)
 {
-       __u16 *words =3D (__u16 *)&addr;
+       union {
+               __u64 w64;
+               __u16 words[4];
+       } id =3D { .w64 =3D addr };
        __u16 v;
        int i, ret;
        size_t written =3D 0;
        char *sep =3D ":";
=20
        for (i =3D 0; i < 4; i++) {
-               v =3D ntohs(words[i]);
+               v =3D ntohs(id.words[i]);
=20
                if (i =3D=3D 3)
                        sep =3D "";
..

