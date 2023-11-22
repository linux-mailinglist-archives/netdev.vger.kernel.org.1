Return-Path: <netdev+bounces-50154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FF7F4BBC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20AA1C20840
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6E4EB4E;
	Wed, 22 Nov 2023 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QYXSA0cT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E2612A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:57:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso6788071276.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700668628; x=1701273428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z0RK/SpWoz+kpe3t/H/b8d6AuI1LIxn2YVK3cS+5J4=;
        b=QYXSA0cTP7ijP9ftrekuu2bi6VOdETFjMYEd7juf2HG4O+aTdMp2lApRD3weEsIDIP
         ZbOA84VJirxkW4sf0kLqnlwgaYWNGnDwlKcVmmeCJtR2MR5brZk6dAb/yH1BDWQdv28c
         pt3vEnPZXIpVo0PyiROCY4Bx3XPSQvzhygyHBGEIQ7pXcMzhI1w23cbdB30hRdWDl4XV
         UNRY5zJmNLTLuqAp/X7S/RG+B4LZVjYNHEA6JYv3Jmj6qOoFoGYBVL/v5xcwBlD4kt/D
         9islFrA4Ju98u4PQTY8GDLVwYj9qAr8TnX6EBcfzDD2nIVMGOQYniGfCa4YrIqE5wxNZ
         RXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668628; x=1701273428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z0RK/SpWoz+kpe3t/H/b8d6AuI1LIxn2YVK3cS+5J4=;
        b=EKM/mc+wjijWgStJUXJJ9jifse4ON3WohxG8uFUYeoemaw3oDL/rn+aLQJ8B4rImUp
         S8qtV+VKlzQ9CLo3CnMxeE8iA6rrNbHaFeQrTcj6p1qfZraGGYp2y5C5449p+WV4r/9a
         Z52rrcrz6pHQDsCv9dPOdfPzjNv28rwBFq3hhx55nFH6oNXWkkDd1S0K0gkfCxZIMooN
         2PQJSUa1uYznricbuu+MKQtsc1IIGUiET5VRb9uFqFCAEnSk+nnl4Bc6rRJ/B2PdHbig
         5CJgdH7BLhwH0dLOJNeVhQQbAZ8m+SEX1vNI0pBWXAmB1Twa0KoFuxSIIZBMxODb7rzn
         3TOw==
X-Gm-Message-State: AOJu0YxPAukhMiW2yNiSYM9ZnqEmzTtROCjZANHAXrm0linqBAU0ge1g
	V1Ah7Dqt0Qrtx+0F/aUY2IG7Q0ehNMKK+1TJMFt/
X-Google-Smtp-Source: AGHT+IE7Sq0ixk+Ro5+SCHHAYlwPM997OhYDeJ/ZdAr2Occ4QlfxYQNKuagMLO9THEFK5O2H3/C6jTykXeNuHGstJhw=
X-Received: by 2002:a25:7743:0:b0:d9a:d184:8304 with SMTP id
 s64-20020a257743000000b00d9ad1848304mr2600130ybc.35.1700668628217; Wed, 22
 Nov 2023 07:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Nov 2023 10:56:57 -0500
Message-ID: <CAHC9VhTiq1xPXXsETNKRBOtfkB5wohVwhBeae+5QW9uV-h5vvg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: Fix memory leak in netlbl_calipso_add_pass()
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 8:55=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@infote=
cs.ru> wrote:
>
> If IPv6 support is disabled at boot (ipv6.disable=3D1),
> the calipso_init() -> netlbl_calipso_ops_register() function isn't called=
,
> and the netlbl_calipso_ops_get() function always returns NULL.
> In this case, the netlbl_calipso_add_pass() function allocates memory
> for the doi_def variable but doesn't free it with the calipso_doi_free().

It looks like a better option would be to return an error code in
netlbl_calipso_add() so we never allocate the memory in the first
place.

Untested patch below, copy-n-paste'd so there is likely whitespace
damage, but you get the idea.

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calips=
o.c
index f1d5b8465217..26a504dc6e57 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -54,8 +54,31 @@ static const struct nla_policy
calipso_genl_policy[NLBL_CALIPSO_A_MAX + 1] =3D {
       [NLBL_CALIPSO_A_MTYPE] =3D { .type =3D NLA_U32 },
};

+static const struct netlbl_calipso_ops *calipso_ops;
+
+/**
+ * netlbl_calipso_ops_register - Register the CALIPSO operations
+ * @ops: ops to register
+ *
+ * Description:
+ * Register the CALIPSO packet engine operations.
+ *
+ */
+const struct netlbl_calipso_ops *
+netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
+{
+       return xchg(&calipso_ops, ops);
+}
+EXPORT_SYMBOL(netlbl_calipso_ops_register);
+
+static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
+{
+       return READ_ONCE(calipso_ops);
+}
+
/* NetLabel Command Handlers
 */
+
/**
 * netlbl_calipso_add_pass - Adds a CALIPSO pass DOI definition
 * @info: the Generic NETLINK info block
@@ -100,10 +123,13 @@ static int netlbl_calipso_add(struct sk_buff
*skb, struct genl_info *info)
{
       int ret_val =3D -EINVAL;
       struct netlbl_audit audit_info;
+       const struct netlbl_calipso_ops *ops =3D netlbl_calipso_ops_get();

       if (!info->attrs[NLBL_CALIPSO_A_DOI] ||
           !info->attrs[NLBL_CALIPSO_A_MTYPE])
               return -EINVAL;
+       if (!ops)
+               return -EOPNOTSUPP;

       netlbl_netlink_auditinfo(&audit_info);
       switch (nla_get_u32(info->attrs[NLBL_CALIPSO_A_MTYPE])) {
@@ -363,28 +389,6 @@ int __init netlbl_calipso_genl_init(void)
       return genl_register_family(&netlbl_calipso_gnl_family);
}

-static const struct netlbl_calipso_ops *calipso_ops;
-
-/**
- * netlbl_calipso_ops_register - Register the CALIPSO operations
- * @ops: ops to register
- *
- * Description:
- * Register the CALIPSO packet engine operations.
- *
- */
-const struct netlbl_calipso_ops *
-netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
-{
-       return xchg(&calipso_ops, ops);
-}
-EXPORT_SYMBOL(netlbl_calipso_ops_register);
-
-static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
-{
-       return READ_ONCE(calipso_ops);
-}
-
/**
 * calipso_doi_add - Add a new DOI to the CALIPSO protocol engine
 * @doi_def: the DOI structure

--=20
paul-moore.com

