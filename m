Return-Path: <netdev+bounces-13173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF573A8A1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7DF2819AA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496E9206AB;
	Thu, 22 Jun 2023 18:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05B1F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:55:52 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D2A2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:55:50 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1985342417
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687460147;
	bh=PtV75OaBKdzmY/UcfFK6R5dQNiYpdr4Cp5P8vJe8O+M=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=V6bEqBz6lQ3IaATvGgwAwOaYgD6SOZQ4GWHOI2lPXMWkXiTHGa+04Xf4uVP+xTFki
	 6kkDS/zmu/ufP8cFTns63Lt1wfl6YB9qIyPEhZtw8C/ZbpPXrkU9x1Tp2jXkHlQyqk
	 eDa+380CjWJUw8qqhXriW58A7uRMbMpBMMVRE/boNJIywhdajDyNOfGWQN8/k9MSQl
	 nQq3hBd+cRZglHLDsPltnyylW6GLimbu8lI8D9ePEbmMrJZU1xWSUvKTU7yQotODbt
	 5Xm1fz9owe5k16b8YMc4M6wq3LJJsel0d2a8Q1uT01JAa/UUpGmjO+/2Mp7/Mj22MP
	 06SZFHzSXH1BA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25e18dac4a3so3460756a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460145; x=1690052145;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PtV75OaBKdzmY/UcfFK6R5dQNiYpdr4Cp5P8vJe8O+M=;
        b=kscitFX4bxUd7xcZlttdY/rLliGsRdlXG2ioWf9R3nD7Sge3t7ECoQzcKfqMw3/xG9
         GopHpVaIa8zqQh7dm3XkUHAlyLzqL4g74bbcTuffPeNxs76AhKv2170mDaL8ZfCwfE6+
         ILpRPdlv7HTiNylyu73Mn0cB19ETnvvrpEZ4TwcwEVwG8eL83KZApIC2hkVAspWKnm3q
         RFz5Yv1M/RHu6wVjvUMPGACXe8icMM3TQSsK7LHWOYbkT+arKE0foLrBKGbcfOPOCBOv
         qsDmcQKdD9It6neYlX3FMM+3xRSjeWlaOSnMcC2T64Y23dKUJUDYSjoYMJE7RG3D/Rsl
         CFcw==
X-Gm-Message-State: AC+VfDx+Hrb2sm9v6QQVk/tdWcoS8AtB3jotza0S25V1vO6j1Gskp7ZZ
	jSlr0umOoutVAbFcPYXhjjQNP51qcMbIYIwKmV9xFGpkjTeOVuaZQbfOcWwkxs4l9gMyEqBwSFV
	XW9nB2uIbdhK8O8F8soZAjXHen5hdSpnSkQ==
X-Received: by 2002:a17:90a:1906:b0:259:466:940f with SMTP id 6-20020a17090a190600b002590466940fmr14504332pjg.22.1687460145509;
        Thu, 22 Jun 2023 11:55:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+y3/CeL70JeI1v/ax6mXc+hxqBdUjnLicOugLtN8pxSstuRtq2GwfLoQaaKzv6lwoMinSKQ==
X-Received: by 2002:a17:90a:1906:b0:259:466:940f with SMTP id 6-20020a17090a190600b002590466940fmr14504320pjg.22.1687460145191;
        Thu, 22 Jun 2023 11:55:45 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0025bfda134ccsm90213pjv.16.2023.06.22.11.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:55:44 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 622875FEAC; Thu, 22 Jun 2023 11:55:44 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5A2A09FAF8;
	Thu, 22 Jun 2023 11:55:44 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org, eric.dumazet@gmail.com,
    syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>,
    Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
In-reply-to: <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com>
References: <20230622152304.2137482-1-edumazet@google.com> <22643.1687456107@famine> <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Thu, 22 Jun 2023 20:32:27 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 11:55:44 -0700
Message-ID: <26275.1687460144@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> wrote:

>On Thu, Jun 22, 2023 at 7:48=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonic=
al.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> wrote:

[...]

>> > drivers/net/bonding/bond_main.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> >index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1=
c0f26d185dc8ff5e3 100644
>> >--- a/drivers/net/bonding/bond_main.c
>> >+++ b/drivers/net/bonding/bond_main.c
>> >@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct s=
k_buff *skb)
>> >               return skb->hash;
>> >
>> >       return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
>> >-                              skb_mac_offset(skb), skb_network_offset(=
skb),
>> >+                              0, skb_network_offset(skb),
>> >                               skb_headlen(skb));
>> > }
>>
>>         Is the MAC header guaranteed to be at skb->data, then?  If not,
>> then isn't replacing skb_mac_offset() with 0 going to break the hash (as
>> it might or might not be looking at the actual MAC header)?
>>
>
>In ndo_start_xmit(), skb->data points to MAC header by definition.

	Ok.

>>         Also, assuming for the moment that this change is ok, this makes
>> all callers of __bond_xmit_hash() supply zero for the mhoff parameter,
>> and a complete fix should therefore remove the unused parameter and its
>> various references.
>
>Not really: bond_xmit_hash_xdp() calls __bond_xmit_hash() with
>sizeof(struct ethhdr)

	I don't think so:

static u32 __bond_xmit_hash(struct bonding *bond, struct sk_buff *skb, cons=
t void *data,
                            __be16 l2_proto, int mhoff, int nhoff, int hlen)
{

	"mhoff", currently supplied as skb_mac_offset(skb) in
bond_xmit_hash(), is the fifth parameter.

static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
{
[...]
        return __bond_xmit_hash(bond, NULL, xdp->data, eth->h_proto, 0,
                                sizeof(struct ethhdr), xdp->data_end - xdp-=
>data);
}

	The fifth argument here is 0.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

