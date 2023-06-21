Return-Path: <netdev+bounces-12481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32449737AF1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FD41C20D6E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C96FBF;
	Wed, 21 Jun 2023 06:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B45C9B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:00:57 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CF94
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:00:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E2B6332008FB;
	Wed, 21 Jun 2023 02:00:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Jun 2023 02:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687327251; x=1687413651; bh=vGeAJVeHsiB3K
	+vbDBbUhfEWGYNOmcNaiXCgCQASDNc=; b=b5DRI8KMf545QVJrFR0DRxj2qSWmb
	6GX2477z8RKFtE/dwZ+hqEauMnypxFeREc+lVbg1EILTYfviR4L2Qgl5bTzIH/ms
	BRzQ8r5ivbiYPJaeJzrG82GCEVlBuZoPeaOie+IgQ0cxGla81ayVYbyyQmfVev7F
	Ife+GqucNN58BZcubhkZKFRRWfx7zeZb5llX45mTU92nevJBVrIUEjPh1l04BMvb
	1vyYCsArFHqbPSmWqSKMYAjQy9v67GNbVaW27/bBLp8YnoVG+qfU9Me3MlCAS841
	wro16tOnpwGyEkppITz90DOb+Hpl0mebpONu/G84qeEhwRsqnRfN59vyA==
X-ME-Sender: <xms:E5KSZCwHAcFSQ-wGbPeeMzhY4uR_dAAaBxrP3k--kl9IDtZhYYohKg>
    <xme:E5KSZOSxZybFtJCiGFsHUWbOBqSFveQ8_jzdQzVQhKqTIkMYcvObPdbQeTJctFA0m
    dUy_lXI6Jp8tpA>
X-ME-Received: <xmr:E5KSZEXuiTEv-FZEALndtroyMgufFDtI4PB96FDCflZsvgf-u13G-zOAdGWnQAI6gTaaSs5MevHS5AuJ1V0CLYM_B60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:E5KSZIjdS8ZOAZ6p-S620RS1J2X5dj9DVm4pdXtdCt4sivAVIDwJww>
    <xmx:E5KSZEBH-fwu6af-xf82VE22k0oztux4p6kgR2w3Fn_f9Lg6-b7Odg>
    <xmx:E5KSZJJyDVzZQ0zPY6PWqDzI8hdqzlmfzqy-9hHKKjJ1Xcv9wnlA5Q>
    <xmx:E5KSZD5Y28fllnZ2nQYl5sCY10VTCWAg4LT2T0i_5R2m3tS6yv8Ktw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 02:00:50 -0400 (EDT)
Date: Wed, 21 Jun 2023 09:00:45 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
	simon.horman@corigine.com, Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next v2] f_flower: add cfm support
Message-ID: <ZJKSDdC+YNlvCXVv@shredder>
References: <20230620201036.539994-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201036.539994-1-zahari.doychev@linux.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:10:36PM +0200, Zahari Doychev wrote:
> From: Zahari Doychev <zdoychev@maxlinear.com>
> 
> Add support for matching on CFM Maintenance Domain level and opcode.

[...]

> 
> Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Few comments I missed earlier

> ---
>  include/uapi/linux/pkt_cls.h |  9 ++++

iproute2 maintainers sync UAPI files using a script and I believe the
preference is for submitters to not touch these files or update them in
a separate patch that the maintainers can easily discard.

>  lib/ll_proto.c               |  1 +
>  man/man8/tc-flower.8         | 29 ++++++++++-
>  tc/f_flower.c                | 98 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 135 insertions(+), 2 deletions(-)

[...]

> +static void flower_print_cfm(struct rtattr *attr)
> +{
> +	struct rtattr *tb[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
> +	struct rtattr *v;
> +	SPRINT_BUF(out);
> +	size_t sz = 0;
> +
> +	if (!attr || !(attr->rta_type & NLA_F_NESTED))
> +		return;
> +
> +	parse_rtattr(tb, TCA_FLOWER_KEY_CFM_OPT_MAX, RTA_DATA(attr),
> +		     RTA_PAYLOAD(attr));
> +
> +	print_nl();
> +	print_string(PRINT_FP, NULL, "  cfm", NULL);
> +	open_json_object("cfm");
> +
> +	v = tb[TCA_FLOWER_KEY_CFM_MD_LEVEL];
> +	if (v) {
> +		sz += sprintf(out, " mdl %u", rta_getattr_u8(v));
> +		print_hhu(PRINT_JSON, "mdl", NULL, rta_getattr_u8(v));
> +

Unnecessary blank line

> +	}
> +
> +	v = tb[TCA_FLOWER_KEY_CFM_OPCODE];
> +	if (v) {
> +		sprintf(out + sz, " op %u", rta_getattr_u8(v));
> +		print_hhu(PRINT_JSON, "op", NULL, rta_getattr_u8(v));
> +

Likewise

> +	}
> +
> +	close_json_object();
> +	print_string(PRINT_FP, "cfm", "%s", out);
> +}

