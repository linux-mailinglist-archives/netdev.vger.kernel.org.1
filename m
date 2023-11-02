Return-Path: <netdev+bounces-45775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34607DF793
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E352C1C20EA9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F31DA4F;
	Thu,  2 Nov 2023 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxzJh1R7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4D1DA29
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 16:24:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621F111
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698942259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWaRCiTgkH9FLCogjLUgD1xSO/P7WPqZ0xtIfK8N4cw=;
	b=fxzJh1R7TanY4ADMhS5rxJofEQWuVIGRNz4nk5Ct7oNIMaalGuVFAhauv9sTwoV67mcfBe
	1w+Sc22Hr9T6Tt/KkAOulzoBg227Jxo35DGxzARoHvGCLRKI0ogfwk6H48cxYekcvxr3kV
	HWlA8Pvt//FoS74BKPUDqM77Idknhws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-A7Bp6FAyNIm_1ejtKM5CwQ-1; Thu, 02 Nov 2023 12:24:18 -0400
X-MC-Unique: A7Bp6FAyNIm_1ejtKM5CwQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4093746082dso1399385e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942257; x=1699547057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWaRCiTgkH9FLCogjLUgD1xSO/P7WPqZ0xtIfK8N4cw=;
        b=RnPhEr7e6xyHnw9dIlascM6twJFochFsx1mXSjeXRXCOEZ2sjCkZKc0WblcdzSwZni
         f3imDNfr1/6QfOkEgqa7SnACizq9+vcFdHFD8gx/LttJiSSBCLpWYyBzsMrNqEZqX7G0
         UgM8b2jCl03qCSbSLhUejcYTvuBd6xwxj41Bw3uIaAgMO7K6PeUJUCl7RVg4b9S9jvOn
         8Vl9VD89oOXp/tChwcGR4U58RJa78rA20fC/MTR85RjiPet25Xjz1fsHwZx2RKTWH7b9
         Gq8e1w0XzBHkrYbnX3dTUdPVxIKJwFpHAWzo3ipPmTG3uwQPoWnlFm6iUYnpLrolEl/8
         jF+Q==
X-Gm-Message-State: AOJu0Yxi/YazV4GyC2pYHCmrdUr8UClnhkYNfB19HACKpU5lAnl1WIr7
	5jsH6r6D/NqgmmI/xUBIRrDi+eRmFL72XbVStDoqENb9QYREmzF3iJipzfSgFiW+FwGAr/YgmDd
	RTXYG8HBK+xbiyKnJ
X-Received: by 2002:a05:600c:1c0f:b0:408:3836:525f with SMTP id j15-20020a05600c1c0f00b004083836525fmr15589583wms.1.1698942257155;
        Thu, 02 Nov 2023 09:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/kSXGXAzQZt+dBmBSqWQ3eIDJ686Chv7gGdkVo+1l5AObtACPBG4+lVXVe1zJHlzbfxdgw==
X-Received: by 2002:a05:600c:1c0f:b0:408:3836:525f with SMTP id j15-20020a05600c1c0f00b004083836525fmr15589561wms.1.1698942256805;
        Thu, 02 Nov 2023 09:24:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-155.dyn.eolo.it. [146.241.106.155])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b0040772934b12sm3628902wmq.7.2023.11.02.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 09:24:16 -0700 (PDT)
Message-ID: <97732cc0a75c0be3f2354075085e7fa6d78e82bb.camel@redhat.com>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
From: Paolo Abeni <pabeni@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com, 
 salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Nov 2023 17:24:14 +0100
In-Reply-To: <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
	 <20231028025917.314305-7-shaojijie@huawei.com>
	 <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
	 <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 20:16 +0800, Jijie Shao wrote:
> on 2023/11/2 18:45, Paolo Abeni wrote:
> > On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
> > >  =20
> > > -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 =
regclr)
> > > +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 =
regclr,
> > > +				      bool need_dalay)
> > >   {
> > > +#define HCLGEVF_RESET_DELAY		5
> > > +
> > > +	if (need_dalay)
> > > +		mdelay(HCLGEVF_RESET_DELAY);
> > 5ms delay in an interrupt handler is quite a lot. What about scheduling
> > a timer from the IH to clear the register when such delay is needed?
> >=20
> > Thanks!
> >=20
> > Paolo
>=20
> Using timer in this case will complicate the code and make maintenance di=
fficult.

Why?=20

Would something alike the following be ok? (plus reset_timer
initialization at vf creation and cleanup at vf removal time):

---
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a4d68fb216fb..626bc67065fc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1974,6 +1974,14 @@ static enum hclgevf_evt_cause hclgevf_check_evt_caus=
e(struct hclgevf_dev *hdev,
 	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
=20
+static void hclgevf_reset_timer(struct timer_list *t)
+{
+	struct hclgevf_dev *hdev =3D from_timer(hclgevf_dev, t, reset_timer);
+
+	hclgevf_clear_event_cause(hdev, HCLGEVF_VECTOR0_EVENT_RST);
+	hclgevf_reset_task_schedule(hdev);
+}
+
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
 	enum hclgevf_evt_cause event_cause;
@@ -1982,13 +1990,13 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq,=
 void *data)
=20
 	hclgevf_enable_vector(&hdev->misc_vector, false);
 	event_cause =3D hclgevf_check_evt_cause(hdev, &clearval);
+	if (event_cause =3D=3D HCLGEVF_VECTOR0_EVENT_RST)
+		mod_timer(hdev->reset_timer, jiffies + msecs_to_jiffies(5));
+
 	if (event_cause !=3D HCLGEVF_VECTOR0_EVENT_OTHER)
 		hclgevf_clear_event_cause(hdev, clearval);
=20
 	switch (event_cause) {
-	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
-		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
 		break;
---

> We consider reducing the delay time by polling. For example,
> the code cycles every 50 us to check whether the write register takes eff=
ect.
> If yes, the function returns immediately. or the code cycles until 5 ms.
>=20
> Is this method appropriate?

IMHO such solution will not remove the problem. How frequent is
expected to be the irq generating such delay?

Thanks

Paolo



