Return-Path: <netdev+bounces-12884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF967394C8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 03:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC432817D2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1B15DA;
	Thu, 22 Jun 2023 01:42:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436117C8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:42:17 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170AEC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:42:15 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B95233F117
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687398133;
	bh=Wu8gNR5XzmtFlhXc3e9U2t84M4h4j+eovJSW+GptXmA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=SxL/9dvITOdiEbzV4DF7QzZ9sH91vsrQQ3XkdEICY3uwkvhZIyTXwBjBXqpNo/Zw4
	 o8C6znUcZdPxqoaWxq3n0vuLTuz4+k/m/W5z6fzm+RtZYBWuS5cNGWVCLktscu/eqF
	 TNuEm13mnFXNRUMJXtZ3Ru2bQNqg4fyiNvSuHjg5MbVhfDoN4r6V5VADkDZWxISbL4
	 BAEIK2iQK++1RvFEn8J8HFRlvoQ9RwR9Q2nF8ID2s3AY95/6mIdUUyqbyt5KOsbkRg
	 518ja11faCfnjRK6RCO+oq+B/eqmUJwxomukKbCalB/UPvcUtOwFkAN25uwxzTnkxt
	 ja5xxQ2sAaYqA==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b53aa1f3ffso32680245ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398132; x=1689990132;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wu8gNR5XzmtFlhXc3e9U2t84M4h4j+eovJSW+GptXmA=;
        b=LoF7LsqvsW1OCn7bH51P/Y3wGEix6YxewQqeKEbzf1kkH2c8n8g6wBr6HOYpWWETOz
         0qYC1dzedF63ou9k6fMWM/+vAmyD1P0ZLg3RcTPZIpqvzI2KCdxOXZ/SLAucDWQ+RPOz
         y4GBT7Uv6wjla11EGE8PSFCy1bi1L3opXSGFFqH0/KPQdnUz3jRt8XfNgcfgQsPrhs8E
         +z6ymhzH9rKLDRwDeJGSuRraSB3GuGvNAfK5N3LlaPzm9KWsIS9Rinavm1sJ4Lnc2eWh
         JqQTbnu2YydahcHoKEiS+d0EUjdPpMNn0EMG/el4T8prQirXX8SUPRBCDiyNPlJpRuC0
         8hgw==
X-Gm-Message-State: AC+VfDwcXkVX+h4uwo+wk6pg9Xf7am0BXxHg2hJNYSWeQVW8gVYn3gN2
	Dp19GdkJZ1PaW5XQzpfqhCIKBlAe/nKw30BSPKmYFTDjQ6Il/TMMYQWudf9NaIbFAOqeiyMpiPG
	g4/3Q6PNBt3uJMvm/ohFm3kCigHgz52+eZWKYO5LEmg==
X-Received: by 2002:a17:902:ce91:b0:1b6:8f1f:fc8d with SMTP id f17-20020a170902ce9100b001b68f1ffc8dmr5299184plg.0.1687398132262;
        Wed, 21 Jun 2023 18:42:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vpI0LClej4VLsmksSZCx5dUNw9ZVPHVNgACs4fVyzzIwcZuxjUR3xx5+e8ailgLzTUdH7cg==
X-Received: by 2002:a17:902:ce91:b0:1b6:8f1f:fc8d with SMTP id f17-20020a170902ce9100b001b68f1ffc8dmr5299175plg.0.1687398131932;
        Wed, 21 Jun 2023 18:42:11 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001b3c7e5ed8csm4089305plb.74.2023.06.21.18.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2023 18:42:11 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id EF04F5FEAC; Wed, 21 Jun 2023 18:42:10 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E836F9FAF8;
	Wed, 21 Jun 2023 18:42:10 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org
Subject: Re: [Discuss] IPv4 packets lost with macvlan over bond alb
In-reply-to: <CAPwn2JRuU0+XEOnsETjrOpRi4YYXT+BemsaH1K5cAOnP4G-Wvw@mail.gmail.com>
References: <ZHmjlzbRi0nHUuTU@Laptop-X1> <ZIFOY02zi9FZ+aNh@Laptop-X1> <1816.1686966353@famine> <CAPwn2JRuU0+XEOnsETjrOpRi4YYXT+BemsaH1K5cAOnP4G-Wvw@mail.gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Sat, 17 Jun 2023 16:29:06 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2023 18:42:10 -0700
Message-ID: <1272.1687398130@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Sat, Jun 17, 2023 at 9:45=E2=80=AFAM Jay Vosburgh <jay.vosburgh@canonic=
al.com> wrote:
>>
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>
>> >Hi Jay, any thoughts?
>>
>>         Just an update that I've done some poking with your reproducer;
>> as described, the ARP reply for the IP address associated with the
>> macvlan interface is coming back with the bond's MAC, not the MAC of the
>> macvlan.  If I manually create a neighbour entry on the client with the
>> corrent IP and MAC for the macvlan, then connectivity works as expected.
>>
>>         I'll have to look a bit further into the ARP MAC selection logic
>> here (i.e., where does that MAC come from when the ARP reply is
>> generated).  It also makes me wonder what's special about macvlan, e.g.,
>> why doesn't regular VLAN (or other stacked devices) fail in the same way
>> (or maybe it does and nobody has noticed).
>
>VLAN or other overlay devices use the same MAC address with Bonding.
>So they work with the alb mode. But MACVLAN uses different MAC
>addresses with Bonding.

	By default, yes, VLANs use the same MAC, but may use a different
MAC than the device the VLAN is configured above.  However, changing the
VLAN's MAC address in a similar test case (VLAN above balance-alb bond)
still works, because VLAN packets are delivered by matching the VLAN ID
(via vlan_do_receive() -> vlan_find_dev()), not via the MAC address.

	So, the RLB MAC edits done by rlb_arp_xmit() work in the sense
that traffic flows, even though peers see a MAC address from the bond
for the VLAN IP, not the VLAN's actual MAC address.

	A bridge can also use a MAC address that differs from the bond,
but rlb_arp_xmit() has a special case for bridge, and doesn't alter the
ARP if the relevant IP address is on a bridge (so, no balancing).

	Changing rlb_arp_xmit() to add macvlan to the bridge check makes
the test case pass, e.g.,

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..f720c419dfb7 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, =
struct bonding *bond)
=20
 	dev =3D ip_dev_find(dev_net(bond->dev), arp->ip_src);
 	if (dev) {
-		if (netif_is_bridge_master(dev)) {
+		if (netif_is_bridge_master(dev) || netif_is_macvlan(dev)) {
 			dev_put(dev);
 			return NULL;
 		}

	but I'm not completely sure that's doing the right thing with
regard to the macvlan logic in alb_send_learning_packets() ->
alb_upper_dev_walk().

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

