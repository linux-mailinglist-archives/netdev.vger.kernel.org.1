Return-Path: <netdev+bounces-20828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F57617F0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0696A1C20E69
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706201F164;
	Tue, 25 Jul 2023 12:05:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649158F4F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:03 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A36A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6BEA05C0197;
	Tue, 25 Jul 2023 08:04:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 25 Jul 2023 08:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690286698; x=1690373098; bh=2w6s+K3MTZSQb
	BPaNdcrUauiS+GL2YaL067xTJaaCRU=; b=xPBdSup5l4TySoZXpN3U5rsbhxfSx
	evnQa2fs7tFSnGRcMwIVrpOftwPuNruUyCrUEX8Gx4JQEhUM+9dERctfFFm4MTD7
	JAQunJl2Oy2zJ1fjvPVPN9aCYsu4l2B0NJgpW/WoCw9JcOBEVB6VwVJh4Zpo8YBL
	P8eE91m3n/A1QBZXho95StdwFd+sv0esd0RuLrjBGwYsWIBMjVGfuGBdi3gaO4YH
	7lGIFyw/vof9K1dssXaXsNSG3HaS8aBb7/HknK9zOzhvWDE1V2dMfBgPEUGP5TC1
	Tk3XTzwPkEljtGoWKkZxWdHJl5zstLkhIncsf6SlXp44JBb5cqveJ+L5w==
X-ME-Sender: <xms:abq_ZA8TOfDqUUyIY3aL4_V39a9-s8lATaRgbGMPc66oWUdCOE8keg>
    <xme:abq_ZIuzNmsNU87VxfD108t0EYG587ZbaCgrb8xXNNiJE2fm2RbqtQE7MPE5CSfP6
    1YE3001xPh0aRs>
X-ME-Received: <xmr:abq_ZGCsHdEB0dtTZ1xy2cOKGMNDW1X8_KY5EreWmcNQNBPXRDf8ncJS29QBHEUlPGlAT25UsoRrdbwprakGIZapq0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:abq_ZAcR5B8ixVBFDPC1S3zgtItnrBMEC0gbGSSTvjAn9h0MIlVh7A>
    <xmx:abq_ZFNOH3yJH0KGFx-pXeiFsm_0dxPaVFxssOecgVZjZ1ft2AflDA>
    <xmx:abq_ZKmHHak2Y5T-3fg7tOSvI_aE7RhRmqNHOXqQBrzgRzHVjLSQPQ>
    <xmx:arq_ZGEbkvCu99B5Vuy07Avzv4rf4iJBobB8N9-1BYOjFYKhMztmxA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 08:04:56 -0400 (EDT)
Date: Tue, 25 Jul 2023 15:04:52 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: flower: fix stack-out-of-bounds in
 fl_set_key_cfm()
Message-ID: <ZL+6ZGsQCPFAuMXK@shredder>
References: <20230724163254.106178-1-edumazet@google.com>
 <sma534z36vpf4ijyalaemiefyze3miqdusp73ewfpegtuuwv6n@vlz6erzympst>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sma534z36vpf4ijyalaemiefyze3miqdusp73ewfpegtuuwv6n@vlz6erzympst>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 08:44:42AM +0200, Zahari Doychev wrote:
> On Mon, Jul 24, 2023 at 04:32:54PM +0000, Eric Dumazet wrote:
> > Typical misuse of
> > 
> > 	nla_parse_nested(array, XXX_MAX, ...);
> > 
> > array must be declared as
> > 
> > 	struct nlattr *array[XXX_MAX + 1];
> > 
> > Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Simon Horman <simon.horman@corigine.com>
> > Cc: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/sched/cls_flower.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> > index 8da9d039d964ea417700a2f59ad95a9ce52f5eab..3c7a272bf7c7cf7d4ae21b5370cbc428086d6979 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -1709,7 +1709,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
> >  			  struct fl_flow_key *mask,
> >  			  struct netlink_ext_ack *extack)
> >  {
> > -	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
> > +	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
> 
> I think we need to redefine TCA_FLOWER_KEY_CFM_OPT_MAX like this as well:
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7865f5a9885b..4f3932bb712d 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -710,9 +710,11 @@ enum {
>         TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
>         TCA_FLOWER_KEY_CFM_MD_LEVEL,
>         TCA_FLOWER_KEY_CFM_OPCODE,
> -       TCA_FLOWER_KEY_CFM_OPT_MAX,
> +       __TCA_FLOWER_KEY_CFM_OPT_MAX,
>  };
>  
> +#define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)

Yes, I believe you are right. "MAX" should be the value of the highest
valid attribute. That's not the case with "TCA_FLOWER_KEY_CFM_OPT_MAX".
Need to adjust "cfm_opt_policy" as well.

Tested [1] and it works fine:

# cd tools/testing/selftests/net/forwarding/
# ./tc_flower_cfm.sh 
TEST: CFM opcode match test                                         [ OK ]
TEST: CFM level match test                                          [ OK ]
TEST: CFM opcode and level match test                               [ OK ]

[1]
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 7865f5a9885b..4f3932bb712d 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -710,9 +710,11 @@ enum {
        TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
        TCA_FLOWER_KEY_CFM_MD_LEVEL,
        TCA_FLOWER_KEY_CFM_OPCODE,
-       TCA_FLOWER_KEY_CFM_OPT_MAX,
+       __TCA_FLOWER_KEY_CFM_OPT_MAX,
 };
 
+#define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)
+
 #define TCA_FLOWER_MASK_FLAGS_RANGE    (1 << 0) /* Range-based match */
 
 /* Match-all classifier */
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 8da9d039d964..9f0711da9c95 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -776,7 +776,8 @@ mpls_stack_entry_policy[TCA_FLOWER_KEY_MPLS_OPT_LSE_MAX + 1] = {
        [TCA_FLOWER_KEY_MPLS_OPT_LSE_LABEL]    = { .type = NLA_U32 },
 };
 
-static const struct nla_policy cfm_opt_policy[TCA_FLOWER_KEY_CFM_OPT_MAX] = {
+static const struct nla_policy
+cfm_opt_policy[TCA_FLOWER_KEY_CFM_OPT_MAX + 1] = {
        [TCA_FLOWER_KEY_CFM_MD_LEVEL]   = NLA_POLICY_MAX(NLA_U8,
                                                FLOW_DIS_CFM_MDL_MAX),
        [TCA_FLOWER_KEY_CFM_OPCODE]     = { .type = NLA_U8 },
@@ -1709,7 +1710,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
                          struct fl_flow_key *mask,
                          struct netlink_ext_ack *extack)
 {
-       struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
+       struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
        int err;
 
        if (!tb[TCA_FLOWER_KEY_CFM])

