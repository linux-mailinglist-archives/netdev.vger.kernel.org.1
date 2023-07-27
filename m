Return-Path: <netdev+bounces-21810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9F764D80
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D752821FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36FBE71;
	Thu, 27 Jul 2023 08:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D77D53A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:35:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2405FF7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690446900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVD8FB/JEADYuMHIOl7mQa3iQ4PtUStU9P5Xc32CT5o=;
	b=hipGTo/lUWQxiJ42v5VPvNBfYwpM3qf+o4j45VnkXSGpzswWkqnfzCtdCj2nGQTckT+1uV
	WCTSJHFP4caAulSPd3FNZc/9C9203HmzitJzPzXM/1bh4436nOqS5AU67FM+yDE/UNMFFs
	JQUmyIS0XATF34Kba6qa3M/nZyyPDHk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-3edAIkkqON-Bvq86ZrTfuA-1; Thu, 27 Jul 2023 04:31:11 -0400
X-MC-Unique: 3edAIkkqON-Bvq86ZrTfuA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767ca6391aeso16341185a.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446670; x=1691051470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVD8FB/JEADYuMHIOl7mQa3iQ4PtUStU9P5Xc32CT5o=;
        b=KuParXvmhVLChmBYKqyrXG8hcbvAimypQvKqTyzYz9ZGDY065Ky06xQAJcOu1EJBtf
         Q2uX43PNoP6WcJNZjJgngUHQtzpvz0JsuyAhPzH0FS8BA9QzkjGgvJ0Xx+Xd+5Xzk5aJ
         SCXCtqKv7AKD0XIb0g+l8//SXDZvMid5vnNE0SEoNptXiGbUK1llQO5XvJW8h3wxVj6p
         u8DqN+fHCCo4l7PD9/uChWPiI9b//9fL19IwhM3XJngNBlEPGMTXI6mRzqUHgl78cNeh
         TGSDK13PfN6HJ6LtmfbhBCjttQpLSluD5BCiOgQ7B21Ps+iVWV2xqViWUpbHpGEkJGgP
         LFwA==
X-Gm-Message-State: ABy/qLYeyU5Qty5719PxYpqL1/pp/WnZPda5jEA9Wv3roY2GTUzc7k1c
	8dePsowyk2MTYOGnA1HfLApGKFbnQld9Xqw4MuLehTNTCFoZYaLMlEPSlrlhIxfCdyqNsVKEkxm
	EwwGiBWeV6s3nkuI1
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4594310qkb.5.1690446670630;
        Thu, 27 Jul 2023 01:31:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlLPIDy9FalbFx9CnNbUIBHGgZByJfZZHP1UkrDoX9N8qwALm8VUiSB8Zz80vyOoBvA7oECw==
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4594291qkb.5.1690446670345;
        Thu, 27 Jul 2023 01:31:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id d9-20020a37c409000000b00767d8e12ce3sm260787qki.49.2023.07.27.01.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:31:10 -0700 (PDT)
Message-ID: <661fb9b145434daeca70accfdee3c3a6f8b3787b.camel@redhat.com>
Subject: Re: [PATCH net v2 1/1] benet: fix return value check in
 be_lancer_xmit_workarounds()
From: Paolo Abeni <pabeni@redhat.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>, Yuanjun Gong
	 <ruc_gongyuanjun@163.com>, kuniyu@amazon.com
Cc: ajit.khaparde@broadcom.com, netdev@vger.kernel.org, 
	somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com
Date: Thu, 27 Jul 2023 10:31:07 +0200
In-Reply-To: <8a5c57dd26f70399a3db012884c2ccb090b00dba.camel@gmail.com>
References: <20230717193259.98375-1-kuniyu@amazon.com>
	 <20230725032726.15002-1-ruc_gongyuanjun@163.com>
	 <8a5c57dd26f70399a3db012884c2ccb090b00dba.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 11:00 -0700, Alexander H Duyck wrote:
> On Tue, 2023-07-25 at 11:27 +0800, Yuanjun Gong wrote:
> > in be_lancer_xmit_workarounds(), it should go to label 'tx_drop'
> > if an unexpected value is returned by pskb_trim().
> >=20
> > Fixes: 93040ae5cc8d ("be2net: Fix to trim skb for padded vlan packets t=
o workaround an ASIC Bug")
> > Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> > ---
> >  drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/=
ethernet/emulex/benet/be_main.c
> > index 18c2fc880d09..0616b5fe241c 100644
> > --- a/drivers/net/ethernet/emulex/benet/be_main.c
> > +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> > @@ -1138,7 +1138,8 @@ static struct sk_buff *be_lancer_xmit_workarounds=
(struct be_adapter *adapter,
> >  	    (lancer_chip(adapter) || BE3_chip(adapter) ||
> >  	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
> >  		ip =3D (struct iphdr *)ip_hdr(skb);
> > -		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
> > +		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
> > +			goto tx_drop;
> >  	}
> > =20
> >  	/* If vlan tag is already inlined in the packet, skip HW VLAN
>=20
> I'm not sure dropping the packet is the right solution here. Based on
> the description of the issue that this is a workaround for it might
> make more sense to simply put out a WARN based on the failure since it
> means that the tot_len field in the IP header will be modified
> incorrectly and a bad IPv4 checksum will be inserted.

... which in turn means the packet will be dropped later, right?

Then I guess it's better to drop it now, it requires a similar amount
of code and will reduce resources usage all around.

Cheers,

Paolo


