Return-Path: <netdev+bounces-36292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FB7AEC42
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BB5B71C20756
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16C2770B;
	Tue, 26 Sep 2023 12:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2561107B9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:17:05 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B947EB;
	Tue, 26 Sep 2023 05:17:04 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QAIpAg025962;
	Tue, 26 Sep 2023 05:16:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=dWXOIzKr3YvQCTmxETjYvRovohbbY4Yz4fKJ63rQShU=;
 b=QnHtq83nQHQZprgW55t1ZotopZuXmwfcrVKbEKnY9WVMMMAn7o/pkQehG5aNPUaCQb01
 5Pemb+ZQB9MkTC+IS3RkwvMotswwokhUmpag8uuSp34s0iV9DftS2S81IznzOIvNrDRI
 +UOU+njRFOenP9v/3SntO6jNwW7w5dnB74r7puHEujuNpqCvIULUwIi6kOwpy0H4MBGK
 QNxb/DJm7kMzLPLFigE4hdXQhFvMZEi9gIAapzetWjdUAQI53xmCRcGPGZuHkh7Gd8Te
 WRJGKtQ0b4TGfFbTCNgw1jP2wrjEY2RRTtLVAxXJN2uzBL43g4P6xYlQs2AjjJlmNiRy Ow== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t9yhm0ugq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 05:16:38 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 26 Sep
 2023 05:16:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 26 Sep 2023 05:16:36 -0700
Received: from [10.193.38.177] (unknown [10.193.38.177])
	by maili.marvell.com (Postfix) with ESMTP id A980C3F7053;
	Tue, 26 Sep 2023 05:16:33 -0700 (PDT)
Message-ID: <f8d79f01-38d6-9385-f213-b34779b8bb54@marvell.com>
Date: Tue, 26 Sep 2023 14:16:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH net-next v5 3/7] net: macsec: indicate next pn
 update when offloading
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca
	<sd@queasysnail.net>,
        Dmitry Bezrukov <dbezrukov@marvell.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <sebastian.tobuschat@oss.nxp.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
 <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
 <ZQxdLZJa0EpnxpCl@hog> <040a3ede-22f7-bed4-0dbf-10b68a9c7fe1@oss.nxp.com>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <040a3ede-22f7-bed4-0dbf-10b68a9c7fe1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 10_H8fETF35UtVTdIfCOJoVNFs9nbO9a
X-Proofpoint-ORIG-GUID: 10_H8fETF35UtVTdIfCOJoVNFs9nbO9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi guys,

> On 21.09.2023 18:11, Sabrina Dubroca wrote:
>> 2023-09-20, 12:22:33 +0300, Radu Pirea (NXP OSS) wrote:
>>> Indicate next PN update using update_pn flag in macsec_context.
>>> Offloaded MACsec implementations does not know whether or not the
>>> MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
>>> that next PN should always updated, but this is not always true.
>>
>> This should probably go through net so that we can fix some drivers
>> that are currently doing the wrong thing. octeontx2 should be
>> fixable. atlantic looks like it would reset the PN to whatever was
>> read during the last dump, and it's unclear if that can be fixed
>> (AFAIU set_egress_sa_record writes the whole config at once).  mscc

Thats correct, atlantic hardware requires full table to be in data buffer registers.
I really doubt its possible to skip PN writing.

>> doesn't seem to modify the PN (even if requested -- should it should
>> reject the update), and mlx5 doesn't allow PN update (by storing the
>> initial value of next_pn on SA creation).
> 
> I updated octeontx2, mssc and mlx5. Atlantic is unclear.
> 
> Mark, Igor, in the atlantic MACsec driver, can the SAs be updated
> without a PN update?

Reviewed the code and the docs I have - my view is it can not.
All the packed record in macsec_api.c:set_egress_sa_record is expected by hardware in full.

Regards,
  Igor

