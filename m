Return-Path: <netdev+bounces-18551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925C757968
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC204281463
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6FC122;
	Tue, 18 Jul 2023 10:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CB253AC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:43:24 +0000 (UTC)
Received: from smtp205-pc.aruba.it (smtp205-pc.aruba.it [62.149.157.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6DB0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:43:21 -0700 (PDT)
Received: from [192.168.99.113] ([185.58.134.212])
	by Aruba Outgoing Smtp  with ESMTPA
	id LiAnqPzimvgrMLiAnqQBBe; Tue, 18 Jul 2023 12:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1689676998; bh=vf8rRyS5/CluQSNrj1NPoDADQa2bFGB0jvt2V5XxMu4=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=Niys/+6heB5NkzwxjkYQAyQywXyYu2wx0CpQbCSvopovq/ZDD+b1ukuQ67gIZ7Cnq
	 pKRYi3kxJuv2h/0IedaDkXsReAhIw8xD/rLGizEMET0dTyMDlGmh488W2sF0Dmyrif
	 nD0jeizvPi5R5r9xvgv9weNju7m8fFueUXZjObGndmXJJZX+fG/K429CKu/lcx9RwT
	 HDobK4hj+eltQ7fJd9FwEvKAwLfvXlYI731qKBjM/JZjidSIWMwVEbeK0LWYS+8am2
	 1BOHxVMfHyhAGaAki0Wp1+kZ240SjXG+Pbb2XYbKB5WCBZORdY50j2HJ1ZD//W+iCe
	 wJmd5QejUkdtw==
Message-ID: <d322c4fe-8e60-75e6-0c8a-10dc83e2571a@leaff.it>
Date: Tue, 18 Jul 2023 12:43:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question on IGMP snooping on switch managment port
Content-Language: en-US, it-IT
From: Riccardo Laiolo <laiolo@leaff.it>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
References: <a9d86e8e-2e7e-fe03-731c-ad4c372d4048@leaff.it>
 <db7508ce-6e92-a199-584b-0a729cd767b9@leaff.it>
 <793efa88-2a97-4cc3-9f84-101eef51962d@lunn.ch>
 <ec7e5d41-f1ba-5211-7637-9ff728599348@leaff.it>
In-Reply-To: <ec7e5d41-f1ba-5211-7637-9ff728599348@leaff.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJVvsxapyL1ldkT33khtc8NqLGGzLjEIYoWHujZK9zhpBl2/BPnTXEYhZS4u86uVFOTqBhxxWKvw9qEER+87gKbKiWvbs69bxJZNWW9hjToDTadGyLRA
 kkQwgOj7XMREtwB6K8wdHVZ4oOZ3HciPZuFSqnz+UyENbF4J1CilHvN8C3mU0ef7gZsKiCgaZtlQIAgAIYhtv+Qlb/YHz5S9SBnnV47vznVmAZSfSE1KG+Cd
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> I think when the MV88E6XXX_PORT_CTL0_IGMP_MLD_SNOOP bit is reset the 
> switch is not
> parsing the payload looking for the IGMP header, which is fine. But 
> when the system
> tries to answer to the querier its packet get trapped in his own port 
> rule since the
> Membership Report destination address is the multicast group address.

Hi,

Upon further investigations, I found that IGMP Membership Reports coming from my device are
received by other neighboring hosts but don't get forwarded to the router port.
This appears to confirm my quoted statement.

Can you please explain why MV88E6XXX_PORT_CTL0_IGMP_MLD_SNOOP should be reset
on the CPU port? Shouldn't IGMP packets be managed the same way on every physical port?

Thanks for the support

-- 
Riccardo Laiolo


