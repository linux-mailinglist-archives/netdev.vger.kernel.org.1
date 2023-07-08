Return-Path: <netdev+bounces-16205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C202074BCC8
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A531C21136
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE91FDC;
	Sat,  8 Jul 2023 08:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF615BF
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 08:15:05 +0000 (UTC)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7CE46
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:15:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345bc4a438fso48855ab.1
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 01:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688804103; x=1691396103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptNjjKXGcwZToYdhG5E+R3gTYS7XOojk1RxLpM+iNoU=;
        b=SsKP+n2usM6BSpSS0v4T5jxv53YUoGnKD4IWnoGFscHZjs2z4mkURqQcT5nsAFhhnT
         rIOQJ5LB3k3mkJ+Wuk9D4MWu57ys1bK889+b4gaJlVez+31zX2TX4+rsSzH3ptXZBa5/
         FPgPTfhNDHwZWIBs3blZnft8cq6mtzRGEco9LnQSza9YapY0o8O/cSZ5QF595whI7zSn
         2YEADBpqqsMyDt94FihTWrlW6QFAuaO32omIUKNEFdfsj59DPOw/6cZqxqQLa/4wYxcf
         ZpjF3pMfSR+BgmQ5rEpWjWqkKlRBQMK0W+xQhz5bh3Wk8hH/m996LO5VOdeGs8UOhbR4
         8AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688804103; x=1691396103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptNjjKXGcwZToYdhG5E+R3gTYS7XOojk1RxLpM+iNoU=;
        b=NyovjtCc0Ye26Vn2syZ4SmbKwqtuFs3bJyVJSTYqwg6ykibWNkzcOCQPQ6d1wQ0kq6
         AoRof3zTUzEJgLRo6uEWqlpRKC8uIaN/7M4VJ8Su1P7yoJVB0Gto80nS4q0nMOhP3OIU
         GRTxtbufyTQWs8/dGMTr68VYtaUsq77fQvpBYxqxA/uGSTfZo3ewZ3J6edQCmLvPzhUn
         qs2DPViSg2GY6LnsN+kQ2FCn3ucQfl6UC69+hmA8x9P+dHp5Ric/c5bYsso4rslTKps/
         lffRIAl+Ohr4cwUz/3cex4+grAYFkPfC88HAk8ITxtf0hbqDPxrUYclTMHMYeqW9PXSS
         1sFQ==
X-Gm-Message-State: ABy/qLarbxg5BssJILtcydl0F3P/ipqvieb+P3TPvhKs9ARm4bDaEsK9
	YWfB9oZV6fpZzNRCxPfdZx9oEYQlbNL4oadyot6LX26XT1JgnUAGwODCzg==
X-Google-Smtp-Source: APBJJlELP4TCw4+VSXJ+gXqjgfDM1XkeqbGZYLVk5wEBZEx10U9fDLLiNYQXYfOM6yBFzp2eJmNZgFKMvVGpRYlvIYs=
X-Received: by 2002:a05:6e02:1ca2:b0:331:aabc:c8b7 with SMTP id
 x2-20020a056e021ca200b00331aabcc8b7mr141547ill.10.1688804103180; Sat, 08 Jul
 2023 01:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707220000.461410-1-pctammela@mojatatu.com> <20230707220000.461410-2-pctammela@mojatatu.com>
In-Reply-To: <20230707220000.461410-2-pctammela@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Jul 2023 10:14:51 +0200
Message-ID: <CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] net/sched: sch_qfq: reintroduce lmax bound
 check for MTU
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, shaozhengchao@huawei.com, victor@mojatatu.com, 
	simon.horman@corigine.com, paolo.valente@unimore.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 12:01=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> 25369891fcef deletes a check for the case where no 'lmax' is
> specified which 3037933448f6 previously fixed as 'lmax'
> could be set to the device's MTU without any bound checking
> for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.
>
> Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink par=
ameters")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/sch_qfq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index dfd9a99e6257..63a5b277c117 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -423,10 +423,17 @@ static int qfq_change_class(struct Qdisc *sch, u32 =
classid, u32 parentid,
>         else
>                 weight =3D 1;
>
> -       if (tb[TCA_QFQ_LMAX])
> +       if (tb[TCA_QFQ_LMAX]) {
>                 lmax =3D nla_get_u32(tb[TCA_QFQ_LMAX]);
> -       else
> +       } else {
> +               /* MTU size is user controlled */
>                 lmax =3D psched_mtu(qdisc_dev(sch));
> +               if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
> +                       NL_SET_ERR_MSG_MOD(extack,
> +                                          "MTU size out of bounds for qf=
q");
> +                       return -EINVAL;
> +               }
> +       }
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
without holding RTNL,
so dev->mtu can be changed underneath. KCSAN could issue a warning.

Feel free to submit this fix (I am currently traveling)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index e98aac9d5ad5737592ab7cd409c174707cd68681..15960564e0c364ef430f1e3fcdd=
0e835c2f94a77
100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -134,7 +134,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX +=
 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-       return dev->mtu + dev->hard_header_len;
+       return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }

 static inline struct net *qdisc_net(struct Qdisc *q)

