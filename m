Return-Path: <netdev+bounces-25681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6692A775256
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E912281A3E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF03D7F;
	Wed,  9 Aug 2023 05:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5D211C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:46:10 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3B1BF0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:46:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 433AF5C00A8;
	Wed,  9 Aug 2023 01:46:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Aug 2023 01:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691559965; x=1691646365; bh=soheFTlkHjLa4
	xnBZ+2WklDn2uPozXTJJ+jMgMWCFv0=; b=xRI/UogoROJRUAeeLyFOQlOg/XB38
	MqduWz9qB0GJqrx9BWR96YFksfIe3XyMvQS0W3Petw1Vg7VbHxyxOqhD4qCug5hF
	H3ZKp8h3Tfr+x3S+LesvVtXQ91CpyOoW55u65DGVHx2VMPxD6l/NdjhgS/s19+Zq
	J3QU+ft+UFm/ED6hnYRplDPn0lxp8TMW7kKIjfVOdaW/K3wDAib2e/WyTN2z63FL
	E1jnOp89+ScTjLGoNVUSlR+k1OifUASFrYNuoosIjSjtr/W9JKFgBlp2Z8NtcsvB
	GGDgICW5/XDNLyvuy+674Us8t2wP1+EPNbVNGrjpvk/fc9e11QFoXSUEQ==
X-ME-Sender: <xms:HCjTZKpZelT-3mC9TApAkFbazvxGlQunhaSMDoC9qnNo_GOHGkq42g>
    <xme:HCjTZIoFVUEAMdBNhXoGpTrYgVy43eq3zUnlPDkIPA1CjDHzo5lpZbEDSx9KHcK2K
    NO4jC7oFHoZp8s>
X-ME-Received: <xmr:HCjTZPOvxfLeP7uxWQ2iBWrX9JXBHh8yNloFOIbstDAgsva1w1F8BDZz6TB3BjKAy9Bu1OsSW5vlYsCrs0Xd79q9D_2wAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:HCjTZJ6oJy0hgdHT9kwKErl9l4H4TKA_zuFq-tJiLeKGqa4vd5QDZw>
    <xmx:HCjTZJ6DTI06AMUhv4LklqFUVlC9RjUq82tHEgGJ0LhQCpbc1Vks-w>
    <xmx:HCjTZJiaYsJBJr-5tmJfeLlqmuvv_ww-rN0nWPT1BN8UUJii4fehVw>
    <xmx:HSjTZEYGk3XrhFpFWZB_DKS5r7V_PuAkfwwLSnPBqso8uJoYR0D8iA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 01:46:03 -0400 (EDT)
Date: Wed, 9 Aug 2023 08:45:59 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, petrm@nvidia.com, razor@blackwall.org,
	mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 09/17] selftests: forwarding: hw_stats_l3_gre:
 Skip when using veth pairs
Message-ID: <ZNMoFwARQ70DPLT6@shredder>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-10-idosch@nvidia.com>
 <ZNLzrj5opo9gra4U@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNLzrj5opo9gra4U@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 10:02:22AM +0800, Hangbin Liu wrote:
> On Tue, Aug 08, 2023 at 05:14:55PM +0300, Ido Schimmel wrote:
> > Layer 3 hardware stats cannot be used when the underlying interfaces are
> > veth pairs, resulting in failures:
> > 
> >  # ./hw_stats_l3_gre.sh
> >  TEST: ping gre flat                                                 [ OK ]
> >  TEST: Test rx packets:                                              [FAIL]
> >          Traffic not reflected in the counter: 0 -> 0
> >  TEST: Test tx packets:                                              [FAIL]
> >          Traffic not reflected in the counter: 0 -> 0
> > 
> > Fix by skipping the test when used with veth pairs.
> > 
> > Fixes: 813f97a26860 ("selftests: forwarding: Add a tunnel-based test for L3 HW stats")
> > Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > ---
> >  tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> > index eb9ec4a68f84..7594bbb49029 100755
> > --- a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> > +++ b/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
> > @@ -99,6 +99,8 @@ test_stats_rx()
> >  	test_stats g2a rx
> >  }
> >  
> > +skip_on_veth
> > +
> >  trap cleanup EXIT
> >  
> >  setup_prepare
> 
> Petr has been add a veth check for this script in a9fda7a0b033 ("selftests:
> forwarding: hw_stats_l3: Detect failure to install counters"). I think we can
> remove it with your patch?

Yes, I plan to remove it in net-next.

