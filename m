Return-Path: <netdev+bounces-202757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C8AEEE71
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F117EFE4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2213D539;
	Tue,  1 Jul 2025 06:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62ABA59
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350535; cv=none; b=TgTCng07jY84nIT+iCMlGdaZN5Yi7J98lNm6ieDiXrgGC/SE7AcOranJUYNatktWIFxwUU8kcyTJ7MXMeYeShFTufZp2MA150ufWf+1ZXIHGojpMTD4Yfn5Oc24LgFcjKEQIzqMsrPFZizIv47bLQm61PFROWY7wNcOBlYQIdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350535; c=relaxed/simple;
	bh=PD4szmsDPR38F116+aysiBptrolBqhJVRS2xPCWWIpo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LSKvEG6zjawH7n8URaGJpzImBbO872AQqUM1UdM0vAr8weiMXEqzs/liUTamLlD4Z3Mb66RHjubDA4HTGIsGSlj9y6lBsQQrz8eeECo7HCk9ebWMeCeS3rUSvy7i69qBjZHpliUh80yFp78P5mgmqNF+9+CrkuS3H0cfybZIDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1751350440t880t41373
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.151.178])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8290655892753390460
To: "'Larysa Zaremba'" <larysa.zaremba@intel.com>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<michal.swiatkowski@linux.intel.com>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20250626084804.21044-1-jiawenwu@trustnetic.com> <20250626084804.21044-4-jiawenwu@trustnetic.com> <aGKRaXt96P18QnIt@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aGKRaXt96P18QnIt@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net v3 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Tue, 1 Jul 2025 14:13:53 +0800
Message-ID: <04ff01dbea4f$5217f7a0$f647e6e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH8lgJmNUT1nEzqioKEahJuXFW8zgIqxZ2BAkW91ZGzt7V0AA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MXzwSMEw1oTNZlHyHLU+knjasMXkKOCu7VypfkO+kAI9F2mPqz84Xz0g
	7aJaZ7rycfZxTaUQVLjm7PFDXqKripDUu3H3/dqAZ/EVNGHVERdMSp/byu/yEjk6S3rwlcs
	yWGBwYU8dtVEUjdmRBGJmJow6mqK9pIYn1/Q1eaHlY4Mgb+AM7F1Kq99KhpfLCb6rJev90q
	6SemTFFlMuSkgr8d/0cdQtmYWE8aXfYfLCOqFQNiiY6qg/cb/Hvg/0aunrwLIEzXsvqNTkD
	MnESqvMrNpTX1NfImqEwl5mBOoQ40hG6ZtIegVQxwJLyzAkisBmyo7r7pby90/mCraaTP8W
	a6v2YlLtG3yyRwozGOiYbdL29vX3A+nniGFLSeSelHSfkKMIE0VQqWSrThfn7Iu6xnIqwG8
	cinPhLI1RuT+da+CD8RJIHH00RNIsuB0Z4DRnQex9SCM5HGGj+8NNrxjLXYNUhOTSn6PDNJ
	mVImS0UvNWqkbr3kMOrsxQWJeskqk5SSmbV/kfxRtmEM7/a/MTjs80j4v37yTVtT4rWZUB5
	mH1v80rTE1VM13CFtLmpD2HF9k5hkBTHiPhoZ6LEmM8Kus6QUTouYWp8gJedFbjsZ5l1bx4
	4PdxnT0L4UFWTxdewdpABYVT2q75gsrQotxJnkg56t5xJ5e3l4zqYLulRUiWb6ucXUXagb1
	NnD8j+Nb4iW8SadvjF6eeZIHFVFpMW2X8t1zq2KsjRdLuTl3G1JvapxjAG8HTKPIfaxcWak
	ksTn3P9CeOSy8HiDC9I0WxEVHgOLhf+A6LsEVRmt34mfKU4cpIX7sJBLDD1+IdY+VimbuXo
	82510kTfpoNtPSZTydn70Is2oBTXmyefp72+jxV2qpYgT/LHQxrFwhVBLGqLNyDQyaghqBI
	0Wd5Prfvvvq1yxvk7c8yk+2mKQPvpm24ax6fl4QRSCD0WP5blstk+UM78P86vYYwGwyJDOo
	9+ojMIAswuu9zx/lxDLABm++5fYF/KO32lDCBENktMH+hmi1VFNmbbaHhSnYSeikGqSsC6L
	pAA720sRTYymGEnr+o1PwQib8kaoVnx6NzfgewuYNB6oPnZ9JuCV0aiOVzup4ltraBbk996
	r+XWFl88QpVS7B0lbUKxIaaYinrCJQaew==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Mon, Jun 30, 2025 9:30 PM, Larysa Zaremba wrote:
> On Thu, Jun 26, 2025 at 04:48:04PM +0800, Jiawen Wu wrote:
> > For NGBE devices, the queue number is limited to be 1 when SRIOV is
> > enabled. In this case, IRQ vector[0] is used for MISC and vector[1] is
> > used for queue, based on the previous patches. But for the hardware
> > design, the IRQ vector[1] must be allocated for use by the VF[6] when
> > the number of VFs is 7. So the IRQ vector[0] should be shared for PF
> > MISC and QUEUE interrupts.
> >
> > +-----------+----------------------+
> > | Vector    | Assigned To          |
> > +-----------+----------------------+
> > | Vector 0  | PF MISC and QUEUE    |
> > | Vector 1  | VF 6                 |
> > | Vector 2  | VF 5                 |
> > | Vector 3  | VF 4                 |
> > | Vector 4  | VF 3                 |
> > | Vector 5  | VF 2                 |
> > | Vector 6  | VF 1                 |
> > | Vector 7  | VF 0                 |
> > +-----------+----------------------+
> >
> > Minimize code modifications, only adjust the IRQ vector number for this
> > case.
> >
> > Fixes: 877253d2cbf2 ("net: ngbe: add sriov function support")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> Looks fine in general, but I see 1 functional problem. Please, see below.
> 
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 9 +++++++++
> >  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 4 ++++
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 1 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 2 +-
> >  5 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 66eaf5446115..7b53169cd216 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -1794,6 +1794,13 @@ static int wx_acquire_msix_vectors(struct wx *wx)
> >  	wx->msix_entry->entry = nvecs;
> >  	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
> >
> > +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags)) {
> > +		wx->msix_entry->entry = 0;
> > +		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
> > +		wx->msix_q_entries[0].entry = 0;
> > +		wx->msix_q_entries[0].vector = pci_irq_vector(wx->pdev, 1);
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -2292,6 +2299,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
> >
> >  	if (direction == -1) {
> >  		/* other causes */
> > +		if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> > +			msix_vector = 0;
> >  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
> >  		index = 0;
> >  		ivar = rd32(wx, WX_PX_MISC_IVAR);
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > index e8656d9d733b..c82ae137756c 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > @@ -64,6 +64,7 @@ static void wx_sriov_clear_data(struct wx *wx)
> >  	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
> >  	wx->ring_feature[RING_F_VMDQ].offset = 0;
> >
> > +	clear_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
> >  	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> >  	/* Disable VMDq flag so device will be set in NM mode */
> >  	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
> > @@ -78,6 +79,9 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
> >  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> >  	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
> >
> > +	if (num_vfs == 7 && wx->mac.type == wx_mac_em)
> > +		set_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
> > +
> >  	/* Enable VMDq flag so device will be set in VM mode */
> >  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> >  	if (!wx->ring_feature[RING_F_VMDQ].limit)
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > index d392394791b3..c363379126c0 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > @@ -1191,6 +1191,7 @@ enum wx_pf_flags {
> >  	WX_FLAG_VMDQ_ENABLED,
> >  	WX_FLAG_VLAN_PROMISC,
> >  	WX_FLAG_SRIOV_ENABLED,
> > +	WX_FLAG_IRQ_VECTOR_SHARED,
> >  	WX_FLAG_FDIR_CAPABLE,
> >  	WX_FLAG_FDIR_HASH,
> >  	WX_FLAG_FDIR_PERFECT,
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index 68415a7ef12f..e0fc897b0a58 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -286,7 +286,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
> >  	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
> >  	 * Misc and queue should reuse interrupt vector[0].
> >  	 */
> > -	if (wx->num_vfs == 7)
> > +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> >  		err = request_irq(wx->msix_entry->vector,
> >  				  ngbe_misc_and_queue, 0, netdev->name, wx);
> >  	else
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > index 6eca6de475f7..44ff62af7ae0 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > @@ -87,7 +87,7 @@
> >  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
> >
> >  #define NGBE_INTR_ALL				0x1FF
> > -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> > +#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->vector)
> >
> 
> In V2, Michal advised you to use BIT((A)->msix_entry->entry in this macro. Given
> this macro is used for call to wx_intr_enable(), I would agree with him. The
> driver is not supposed to control msix_entry->vector contents, so it is a poor
> choice for such hardware-specific writes.

Thanks! A clerical error almost caused a major mistake.



