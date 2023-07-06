Return-Path: <netdev+bounces-15882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B987574A3E9
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEFF2813ED
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB52AD5E;
	Thu,  6 Jul 2023 18:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF71872
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 18:51:40 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C321BFC;
	Thu,  6 Jul 2023 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688669460; x=1689274260; i=markus.elfring@web.de;
 bh=XjCNBnIa10jVejqfMDBBpGc+o1vv73owKwGqp+XeIDM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=gqJbrYN9VZ7CLtRm6/Mw78ZQowCE0EHcMUaIQC7wZw9QD3W8B7Lvxc0J7ocPDIuhuW/6QB/
 zz2aa7YznO2ce/jizFdGTSEV6VKDVWyBaexI1b0awgVvf8knMSIx81Yp0pX9wX4Sit1MEAw8g
 XfAhkPscyz4O4OLfHHBWwG3eJHd5Zr+8d1aJxA5S+J95CGcUQXpTeiwS/qo4t4oagoPNgZ1Sc
 J9Sf2xOu0jvzweRVFfnIXiNv3pblua+htXXChJ6dC/DGnIG49GxWhxSWY7IcE6N0WrZQcnqxD
 OTi8mi6uP9p9SQ9QaDZtRQkzdBqf0PD+tZgMG8EuufhaUfQUWVjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1pneUT1Kkn-00hEIe; Thu, 06
 Jul 2023 20:51:00 +0200
Message-ID: <b3cca696-31b2-3557-82d9-1606c819a46b@web.de>
Date: Thu, 6 Jul 2023 20:50:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Wang Ming <machel@vivo.com>, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ying Xue <ying.xue@windriver.com>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <20230706134226.9119-1-machel@vivo.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbmV0OiB0aXBjOiBSZW1vdmUgcmVwZWF0ZWQg4oCc?=
 =?UTF-8?Q?initialization=e2=80=9d?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230706134226.9119-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7YyVsQwwKpgADv3U6h+2dGJ6TlnvB77ux0QIvoOc4Ue80JmdA7f
 cR4jSTO5NkCUwOXnsg2rN1l345Tiq9fz28lOkV/RTywqBGMYymylnDdP02/I8v5NBIcHOec
 qf2auWvZ/zmbJl56NRkB+NFnzVKOyQnrtBLb3xdddtLYDZ2pfmE2+B/3LewjN/0atcs2S19
 nx3jaLWuiZb4HnoiAzg3Q==
UI-OutboundReport: notjunk:1;M01:P0:8f/CtTCK0W0=;Xf1U11CO7ySALQCr1lchWcKdP3v
 jaE+5rznXNEuBA5pR4/ukTroaqqxA0VG7AnI3CtCkn65oZWjviTsdBBDVzJ3Wa9eif8NYhIOK
 Xb0IimM42mbLZ66SFSHbyLrjDG15g++E8IggDarpchyvI3WjAIThE1ic5eFPQR9kuIj+fogMv
 EwHrt38iOV+wUEgzIz7zG44ncOmRBUzYmej2zeA7IrRw3IsUUpeATUcYO/c/St8QSeYg0Dllp
 f0vxutI0bt4DQ2Z5MGbfWmSmuSFUgJ570mm1pBmWBLyxdb2GqWC5aAQVcQIW6GXKBw4RFFL21
 YNNtvrmhVjwaL35zLqKLwjSbWXu8QCWjOw6zlcEMChRx3CazC/d5M1qgZ2Aa58L8zWAjI03v8
 CfBfrXtLwg24vCGLnxDDgg+y2YlNfV/DuwwPKCWF24lZ3hXjaXu/3i5idX3S3igRe/4hldh5y
 oCzzJNncHCDEykzL2YHdPOdVDurpYuhpVuTbTZd4EgtEiffvKqGu5uwosuVr+XO3aARNIw38L
 vhf5gt//IUdKl2RyTCUQJyb0s+CggR5OBSIKd1vEgavpXp+iT4X8P+qm3l/yQEoNagDIy6tSc
 hXzx+xQi6nfhPpMxV1vMrKd8Q9tQZnGU//PQRBxQHbJbW1kzUTtd2MbBDHtNt5H+f+N4tKmuO
 BB3+Az+y6x047fq+A+SGs3/D7c+B9bvyZY6sf4DYcM6TnXlqjCKSTCejdQ1sr5tQKXkvo4uFl
 jcictkmt56SjCURgDIfFHRe3UjQxQoM+d2JxSOnM3ng81BnkAEeOgsYnVxnY8W2f+JJ/CHJSh
 nZLKGgieqmHbkR33Y7+r7Lo26mPw7kkGOozYH896+oT7A5TqYPXzA0rzIQNcoXxYo+0L1L9jK
 dmKqd8LMyMaTuAFKzMM5cInYqh3Q8TpjiB8pRXoZK43NE/9NHhoboilJ3fpiutSll8kadl9YD
 w2K9yA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The original code initializes 'tmp' twice,
> which causes duplicate initialization issue.

Is it more appropriate to refer to a repetition of questionable variable a=
ssignments?


> To fix this, we remove the second initialization
> of 'tmp' and use 'parent' directly forsubsequent
> operations.

* Would you like to avoid a typo in this sentence?

* Please choose a better imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n94


=E2=80=A6
> +++ b/net/tipc/group.c
> @@ -284,8 +284,6 @@ static int tipc_group_add_to_tree(struct tipc_group =
*grp,
>  	n =3D &grp->members.rb_node;
>  	while (*n) {
>  		tmp =3D container_of(*n, struct tipc_member, tree_node);
> -		parent =3D *n;
> -		tmp =3D container_of(parent, struct tipc_member, tree_node);
>  		nkey =3D (u64)tmp->node << 32 | tmp->port;
=E2=80=A6

How does the proposed deletion fit to the function call =E2=80=9Crb_link_n=
ode(&m->tree_node, parent, n)=E2=80=9D
after the loop?
https://elixir.bootlin.com/linux/v6.4.2/source/net/tipc/group.c#L277

Regards,
Markus

