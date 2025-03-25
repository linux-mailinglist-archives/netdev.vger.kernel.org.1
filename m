Return-Path: <netdev+bounces-177278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B76A6E85B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 03:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF85416B140
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F41E86E;
	Tue, 25 Mar 2025 02:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA95228
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870212; cv=none; b=otxJePyFIpPnLmx0vjdrh8fFvoJsi5zQxd26b3sforsTGrwb7HDv4MuFgsJal8ds7Hy3RAK14Olklt5G3LUaMzjYlCGcJnhAWtO+vY+65oTsyJHkxD5bI9Vj65AcnhoCUOPE421Nvl58afN/LTRpwl+eKGDFWlfg8RkqZwH+X6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870212; c=relaxed/simple;
	bh=YoWSIGmLBzhVJBknsaqYrwnGm3meNqWUcZmxXs/Gt+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pfwazPRgE33mt3EcdOotCrECPJV/Poijv7NcZ08PR13vUClVbkDioAXbR1bLoWSZPjE0B1xF0ufXDtX4buLZ/7iaysF07tX4+529+19Ov0rUr8JrlmNmUJxyk72piE9QBy9hhyjFp4ZVbDAz+4pNUQRQ/Dd4HVQZCCLH6MOxx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp88t1742870172tzo03qgm
X-QQ-Originating-IP: HYRKhQSrRHRSocoDSwGFUgw6AGfZPEjOn+5hBlsAvq0=
Received: from smtpclient.apple ( [115.195.133.16])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Mar 2025 10:36:10 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6708647151829778251
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [RESEND,PATCH net-next v9 5/6] net: ngbe: add sriov function
 support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250324192116.GK892515@horms.kernel.org>
Date: Tue, 25 Mar 2025 10:36:00 +0800
Cc: netdev@vger.kernel.org,
 kuba@kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3FEA7AF-1990-40DF-903C-30790ED782E9@net-swift.com>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <9B4D34D65A81485C+20250324020033.36225-6-mengyuanlou@net-swift.com>
 <20250324192116.GK892515@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MiFKngPgK6qHKheJE6sb2hczQLFqL2VwYQQFlkTpw0j02weKNTy6YFTT
	+PSXvajXmc/+Xs67k0Xdv7OBk8DlW5RBN1ZucsjzzDULzjcs5zBJI+jk7BVdbMSALuvkztp
	bbz82qazKCJ5KPE1zWVQoah0WvfV0fgujHbQe59FLTfZvOy8HCimWHyQ2H/riTEXxiom19T
	2vxF6MRV33Yluio6vCEp5K5/JFnGd/T9XcHSzpaBf6nqF8y2+zyXgbUorgaTQ5abZ9SQhQm
	YxqYP06LjGqzlpUIQrK080QyaLHewo9r25469u6RTyp8k7CcfnyhxfjLoGAlVj9+i5mzy2M
	WfrOcEhc+GE/IdTY7pRIQUU1TmFNLaipo5WNUjGUBuQ1Fscgo0m57lTujh2/RTQNNzaxD5p
	Wv3nykMSP0yB7QHgnrYhOpi+KD5O5UMWj8DFYPRwh7cM2fbZcB4lPtLx2VQmN3zRdHw/Zxh
	85NVso7LVdGJCOGVKw73kFHK/iANRGzEwv6Uk1QP3Z6g+p6PWGu5I3UCCHbRVcEJ572dAE7
	pwe30wVr9L1K6/C0WuX4rgGSUhcA0+RjnuQtDWNJc5MPwvkaxzcIEC7+oi4o8GfzhbUZcSO
	cXh/NAHzwXn4VVBfGuAcno4ltne4H5Qm3u73997xUK+1xX5GrYOR3jcjuk+7GFFquZxx5hr
	/1leCgW4dtBpnM5qxI2xWOWIoqnTZJxu2FjVprQ5kqBJNuw3XxIeYke737SMEyh4ga6jPZn
	SRl6Yocg+XkKOHWc6ppWB3EhPPCduvR3xdqbW4ueo32UNlAVT5LQKRyyALw9c5RQsGXur4t
	+E3chKsHG6W5SwF+M7KusTOwO9ueWMJHTZFG5UznFpyoHNiiX3oNyRUFSFsThAgm6mMOKA2
	IMywi+rAnOb2IK3nGEkCxhyPVvqRBnjednyUSQ1NMa9o2qYE7aN3f+eK5n2/QXISETEfrxl
	igUvcbRMn3Rw7fjiuDjvFLdWDPHNlJULqi4LKoumqxRwfUrsIWiq2JDRnovrVYmSAtmc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B43=E6=9C=8825=E6=97=A5 03:21=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Mar 24, 2025 at 10:00:32AM +0800, Mengyuan Lou wrote:
>> Add sriov_configure for driver ops.
>> Add mailbox handler wx_msg_task for ngbe in
>> the interrupt handler.
>> Add the notification flow when the vfs exist.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>=20
> ...
>=20
>> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>=20
> ...
>=20
>> @@ -200,12 +206,10 @@ static irqreturn_t ngbe_intr(int =
__always_unused irq, void *data)
>> return IRQ_HANDLED;
>> }
>>=20
>> -static irqreturn_t ngbe_msix_other(int __always_unused irq, void =
*data)
>> +static irqreturn_t ngbe_msix_common(struct wx *wx, u32 eicr)
>> {
>> - struct wx *wx =3D data;
>> - u32 eicr;
>> -
>> - eicr =3D wx_misc_isb(wx, WX_ISB_MISC);
>> + if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
>> + wx_msg_task(wx);
>>=20
>> if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
>> wx_ptp_check_pps_event(wx);
>> @@ -217,6 +221,35 @@ static irqreturn_t ngbe_msix_other(int =
__always_unused irq, void *data)
>> return IRQ_HANDLED;
>> }
>>=20
>> +static irqreturn_t ngbe_msix_other(int __always_unused irq, void =
*data)
>> +{
>> + struct wx *wx =3D data;
>> + u32 eicr;
>> +
>> + eicr =3D wx_misc_isb(wx, WX_ISB_MISC);
>> +
>> + return ngbe_msix_common(wx, eicr);
>> +}
>> +
>> +static irqreturn_t ngbe_msic_and_queue(int __always_unused irq, void =
*data)
>> +{
>> + struct wx_q_vector *q_vector;
>> + struct wx *wx =3D data;
>> + u32 eicr;
>> +
>> + eicr =3D wx_misc_isb(wx, WX_ISB_MISC);
>> + if (!eicr) {
>> + /* queue */
>> + q_vector =3D wx->q_vector[0];
>> + napi_schedule_irqoff(&q_vector->napi);
>> + if (netif_running(wx->netdev))
>> + ngbe_irq_enable(wx, true);
>> + return IRQ_HANDLED;
>> + }
>> +
>> + return ngbe_msix_common(wx, eicr);
>> +}
>> +
>> /**
>>  * ngbe_request_msix_irqs - Initialize MSI-X interrupts
>>  * @wx: board private structure
>> @@ -249,8 +282,16 @@ static int ngbe_request_msix_irqs(struct wx *wx)
>> }
>> }
>>=20
>> - err =3D request_irq(wx->msix_entry->vector,
>> -  ngbe_msix_other, 0, netdev->name, wx);
>> + /* Due to hardware design, when num_vfs < 7, pf can use 0 for misc =
and 1
>> + * for queue. But when num_vfs =3D=3D 7, vector[1] is assigned to =
vf6.
>> + * Misc and queue should reuse interrupt vector[0].
>> + */
>> + if (wx->num_vfs =3D=3D 7)
>> + err =3D request_irq(wx->msix_entry->vector,
>> +  ngbe_msic_and_queue, 0, netdev->name, wx);
>> + else
>> + err =3D request_irq(wx->msix_entry->vector,
>> +  ngbe_msix_other, 0, netdev->name, wx);
>=20
> Sorry for the late review. It has been a busy time.
>=20
> I have been thinking about the IRQ handler registration above in the
> context of the feedback from Jakub on v7:
>=20
> "Do you have proper synchronization in place to make sure IRQs
>         don't get mis-routed when SR-IOV is enabled?
>         The goal should be to make sure the right handler is register
>         for the IRQ, or at least do the muxing earlier in a safe =
fashion.
>         Not decide that it was a packet IRQ half way thru a function =
called
>         ngbe_msix_other"
>=20
> Link: https://lore.kernel.org/all/20250211140652.6f1a2aa9@kernel.org/
>=20
> My understanding is that is that:
>=20
> * In the case where num_vfs < 7, vector 1 is used by the pf for
>  "queue". But when num_vfs =3D=3D 7 (the maximum value), vector 1 is =
used
>  by the VF6.
>=20
> * Correspondingly, when num_vfs < 7 vector 0 is only used for
>  "misc". While when num_vfs =3D=3D 7 is used for both "misc" and =
"queue".
>=20
> * The code registration above is about vector 0 (while other vectors =
are
>  registered in the code just above this hunk).
>=20
> * ngbe_msix_other only handles "misc" interrupts, while
>=20
> * ngbe_msic_and_queue demuxes "misc" and "queue" interrupts
>  (without evaluating num_vfs), handling "queue" interrupts inline
>  and using a helper function, which is also used by ngbe_msix_other,
>  to handle "misc" interrupts.
>=20
That=E2=80=99s right.
> If so, I believe this addresses Jakub's concerns.
>=20
> And given that we are at v9 and the last feedback of substance was the
> above comment from Jakub, I think this looks good.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> But I would like to say that there could be some follow-up to align
> the comment and the names of the handlers:
>=20
> * "other" seems to be used as a synonym for "misc".
>  Perhaps ngbe_msix_misc() ?
> * "common" seems to only process "misc" interrupts.
>  Perhaps __ngbe_msix_misc() ?
> * msic seems to be a misspelling of misc.
>=20


>> +static irqreturn_t ngbe_msix_misc(int __always_unused irq, void =
*data)
>> +{
>>  ...
>> + return __ngbe_msix_misc(wx, eicr);
>> +}
>> +
>> +static irqreturn_t ngbe_misc_and_queue(int __always_unused irq, void =
*data)
>> +{
>>  ...
>> + return __ngbe_msix_misc(wx, eicr);


if (wx->num_vfs =3D=3D 7)
	err =3D request_irq(wx->msix_entry->vector,
			  ngbe_misc_and_queue, 0, netdev->name, wx);
else
	err =3D request_irq(wx->msix_entry->vector,
			  ngbe_msix_misc, 0, netdev->name, wx);

It=E2=80=99s more appropriate.

Thanks=EF=BC=81
>>=20
>> if (err) {
>> wx_err(wx, "request_irq for msix_other failed: %d\n", err);
>=20
> ...
>=20
>=20


