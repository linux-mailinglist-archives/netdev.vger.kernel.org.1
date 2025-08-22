Return-Path: <netdev+bounces-215916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A1B30DF2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A982E6851C2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619728F92E;
	Fri, 22 Aug 2025 05:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34F1A255C;
	Fri, 22 Aug 2025 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840214; cv=none; b=DxjzK3XZxYRDno2nUwr7UXs3PY2/5E+CDcRb0JNKXcbOtnxhKS9vHzgLfDd5KtGH7Kr6wd/DJDLBgn5Xdqs7DLU58ff1r/YBNiMBIiUzG1WrOGKRq76VGEWhv4U6c8zFss5H5P2Oeu3UkL0aVznG4bceDz86dEq2QANhO7AludM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840214; c=relaxed/simple;
	bh=vqrYwUwAVs5X2DPvqk2UlNCPO6LGG4MO76/HcDklnnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkxe4x/3iyqbmNsIup7OXbpUMGR8kKsIGrqbzQkKPNwPhlDqJ66p9qRp8YRCKXbofsmL/2jqstHy2B/t02d6fX9QJiNNzv0xxfTK94A4+dW7jVsFoFP/ovGQ5BBQc9BnaA0ECwdGOUYs11Lyp+HgQHpHEHn3x8avOgC/1rihrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1755840193tae549ba7
X-QQ-Originating-IP: 5NgYGNwVjuXw11VeCT6N7t3/42rH5L5UVcwCtVF/r0o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:23:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3820646082963758569
Date: Fri, 22 Aug 2025 13:23:12 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <4DDD62E86FE72117+20250822052312.GA1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-2-dong100@mucse.com>
 <f66e4b61-c547-428c-a947-57ea2a71c1ea@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66e4b61-c547-428c-a947-57ea2a71c1ea@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N9NPDBT3mqrZLsZ7F6BgRy9k2ik21+2AOLKDOHWHHJ+9kox3gRon9lM1
	2QQ75Fc190KoR5XfUJTKwzooca4o+Ipng4RkW1dKauczL8iLDf4lvhoP9ibXJCJTYYWRo5t
	Z5ePEeDBZq3OljNU2zIH4ceEWc4lI27Eiw1Xo0hny/p5+wkiPG2hY9UPNb6XWDDIB5tkQ58
	1sK0SIY/zKmiY7IrwKAXGl84X7DNYjma7Ib25KsjmUoNgNS8rkTw5QFn1+MVCs0rOzYZ3dv
	FNt2lMEBdU9jzjPfIHaY8Wb1/o8J851j5reSRmnaGjYVu9bK0AdNVyVuWWLX9IU6hjB4pMl
	11KHHRjx8i7HPtfSeKsY89OuEUkOl+O4ptWSiBmOlwuaOhEh1zhMwfnntNX3zMp2Qwqw/4A
	o9unV74734sLtWgQ5GvBEUSoU+4AfBGJ3qHRU+Cc7Ux5TgrnA9K3YF7NGaJmltoc2Urj0ct
	DNPIGCCoG5w6iq8yHfXXGMyF6TKfY2GVhv1aQZ4N2kc2gq7QGSQ/Z23fNncMvvoP8JmSOIa
	+Bh7bjuktUBcZDrdc7NwW7X+ryOFEXjF6TJyTN83EYVnFY4XL/zEn3SjKT1XmWW6hiSX6Ty
	kQk7K+ILcRXeWFn3Oumqj0pHBOHS7K7rNWIN63ghS+P3bY5RPw/0G/9C5ZQ7Pyr5y2VYbbL
	rAMFJTqKwfKPdt4PN7KVFJkNDpKzfOiLyuOb0Tcu1LlQt7evGgwyCA+JY0DU+cWlLxcnzCS
	FQwDAiiFnG/ymSuUeKTGrrXr/QEGPe1kpqmR4F7uDxh7jfFsIhz1TvcHhvHgTNXCTiNyht/
	SgiyE7jIzZKqubvdW+kt46YpImSHy9zg0h/Ypg+kr7o/48dczi988sW6nfOpzPzphVIn+9a
	iTc6abni6PJWAFKBDkKWkdMo5FxllXNwZrsPw9yznmFE/c6Q+LCVjP3jmRaFdeYAorDDFnN
	3x2a6RX346rzxVW2uaHLsgXq07+RBXI5DItTPm/O0i2hCMxzBpw1/YnbDo2TSJz5a3yI=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:32:06AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> > +
> > +/**
> > + * rnpgbe_probe - Device initialization routine
> > + * @pdev: PCI device information struct
> > + * @id: entry in rnpgbe_pci_tbl
> > + *
> > + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> > + * structure.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +       int err;
> > +
> > +       err = pci_enable_device_mem(pdev);
> > +       if (err)
> > +               return err;
> > +
> > +       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "No usable DMA configuration, aborting %d\n", err);
> > +               goto err_dma;
> > +       }
> > +
> > +       err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "pci_request_selected_regions failed 0x%x\n", err);
> > +               goto err_dma;
> > +       }
> > +
> > +       pci_set_master(pdev);
> > +       pci_save_state(pdev);
> Don't you need to check the return value of this?
> 
> Best regards,
> Parthiban V

Ok, I will add the check.

Thanks for your feedback.


