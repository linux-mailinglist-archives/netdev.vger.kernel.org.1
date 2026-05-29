Return-Path: <netdev+bounces-293004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AYFFT41GWqdswgAu9opvQ
	(envelope-from <netdev+bounces-293004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:42:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5F5FE11A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99F773039895
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858A3AA1B6;
	Fri, 29 May 2026 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="myui/KH8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936B2FE074
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036915; cv=fail; b=aLnUtl2nq1IP1xrJjXt1Ko+IfmyNs4R2V8oy07DBWjpeRv8p7gveF8OidouCBG0NNgx4Y7x2FUM1URR9bymPh6Oc995Wa1NHW+Ed7lGNJ2sZ6ewx+PHy3eMstUvYqAyV1kMXVuxDZ708iiriRsVN3zKsujeT0dbsk+3U//v+/WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036915; c=relaxed/simple;
	bh=RUFhAdhfxdt+409Lo5x+VBLswnLbP635ULre/4vDtdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKUXheVwYsSCz0vx9XIU1KLhqo7baCQu5T15hK9+rLS2xwzI63AyH8F2/iyClo7PLUIDh/iSdHlRl2KVPf4N/iIkwwu3XfAivA6yt2lONTO3qyGxmmQLmxTICGseRpZBeYYBZ2r7CNs6wP9a8ec/A8sY4A1p4N137oK6pFr6Wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=myui/KH8; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64T2ePdU028312
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wjl2lJMhu3x6YF6VZMdTDkNQcozAcKqTdHEY7+axmxo=; b=myui/KH8juDb
	9VFRxDDFEIimNoAd5XwHhraUO/L1qE4ZtZnO5K+/nzprny+oPTbRJWHwUl7Iab/B
	cMLPIr8HMpKYeWusLbb/K+iwCBNNEvNQ4TbH/N8JWoEGZzYAl66wAE0qc8sarvKy
	NYv2JsEurivQoqaAHfEmVHaXwieB82fQ7S1h7lyRTkK45xQ7kvSunBJhbh5mhqcS
	R4u4gH7+DhvThFUOuSUwR7HsCG5Cx58JsKiG3AGPcpDd3+2CHCL50PZkKvpuBsSW
	56zV2uZKI0BOQNtMOtj246H6KVeuu5CBuNc+Twlud+11KyL2joGJMeL7vJmJjcwU
	nf9M3D97/Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ee7xg29q6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48576b309c7so8579508b6e.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036911; cv=none;
        d=google.com; s=arc-20240605;
        b=jW3SV0eSxeCSUiFqpE8iDomPzbmZHsfFg1bYZNmb4d6ruHvQRH5vHFs3sjSq3UzUVC
         okKzOpCq1qsBfqYfOIcZXVeZAzdl2KtEYPjB3xoX1MXoAcnfxVKOx67IrzrqbYWU8Sbq
         nBNcbeP3sjoDJrqQjW2x/oPD4rR1oc5xaJA/K+/KZWLzmzNXh22GzLjlAa5TVeADIeLP
         3pxtJcYaIv5UCbg11VGXyrRcTwGy1zXxx6N2ICQ9so9GWaJJtiFgqMlTOtJPiXE/yY2+
         V/hWVIvfzjUohk1VPazA2hgoPGrHX4eFVAD0PxV5RhucKGJlw8WYI63dCvIgXDl/L9vZ
         J2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        fh=Nf8wVy7ykNH6gMwu2PhVBnDm1v8PBIRc34n50q/3FiM=;
        b=AbBcwDwUsbOHnePRBOh1YRaSEgiBnXf1C3SSNrKrjX1WWKa8cublcnnpkTB1HOp1Xv
         U8A8IWlmIfs8iIt5k+Zz+cDCRK1PGNrR5+i511smCULmXSLC7SWrYyBIwpi08VUbIGQR
         0sh7U1pLOF5NzKoLS+gDAjOg1czZrSfBwRtec2xAPGns36GKxXaOp+EFGE8uaBqF/vj8
         iFCjIKfri/R1UTn6yO+PS0lrXx16d5k0yQ7dv/y2CkRnkTToQCa82nhNJ/DiDONE/4EU
         G1d+ig40mDkzeZNiGB0q4KdG0A9nwW/6BT0lug2hSWMgar6+c8Zg6vpp+3SYC5B3AwtQ
         +jiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036911; x=1780641711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        b=pJqNO/+R0dyI6SWc0kUlgsE27sgUPJj0+sekSPCw7dHiUovXG/wsu1xuCPLWK+juEo
         ja+auV+fJ8Hn8SrfWzYbkA5OhboMQKAPF61/JGbMTktlFF2IDByo7EC4uRz0Kq4xVwfd
         XX0dhZqTUhaaB8xQD2futBF/p6UsyWX9PjYAlsjyoZcKFMEP5HLSVDLA+vmbYLFq8vc9
         CRQ0ZKYM4UBjTGUVfPFumz2WZTJ5+2qFgh+xH7NTbvndulhTYxvI7/TUW1CkwnHC7G2K
         ahBoGeMULIvfsMl8Km9YBCenK+IQzFLO0m+AxAB2EmL0OOalLCLQfZWewPab1tYcnLn3
         5nVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/db6ziKnbVO7TqoKLdCg7wJrgFmYqeBUCVMhiw6jGIpVdb4XEFvcSs7qH6KMuBFXo4YY5m+FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSELPhc6/GA8e6pt2J3ZQi706H6cw4BPGDEGQ1V+VpbqDXFdVf
	ej4V+6C2GYl9CBQYlD6fQY0STJSvks3L28yUShphxx3+nMv2QQMmwEfdO8DtodyGouGtCrMnE70
	lThuTb28ZQn58X5kOZg+mT54tcUtfxt5DR4CFbne8WK3dkIPDPSup8fgj0+KTJTonhwO2HQOku8
	vm+qm0CRramphfsWxuWrThll0QttXVYEg=
X-Gm-Gg: Acq92OF1ngzvT2fqxOBs0e5na0KZZ5yvOankK8yBofWXesZhFwaKAFTlkce+F/Zu4MC
	C+1H4R+ACiS2B2NT6bBIBWkn9WHclTTFnCCTyVsfo1qoKt7KTnUxvVzQhv+2gfqDowuKIO7r4vB
	L+rpIwVypxz3YcTmC4xyHM0+OLlPXy8pdKQ5dDj8BtotYLCsrQeIlV2UDd6196tsXSDgzJQunMs
	+5HFPvuxspQ6p7bdP1pt3OJEX+0vWAw98ym9oElRsyO0ZuH9lg=
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id 5614622812f47-485e6dc0223mr972283b6e.35.1780036910672;
        Thu, 28 May 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id
 5614622812f47-485e6dc0223mr972266b6e.35.1780036910218; Thu, 28 May 2026
 23:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org> <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
 <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
In-Reply-To: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:41:39 -0700
X-Gm-Features: AVHnY4JOme_X08lKUfayqc49fxg4J4ab3o3Y14UzTjVjHMNZxrhWL7QV4gYwqO4
Message-ID: <CAH3zFs3eddZUtb08oNpjEg5b2=DJtRCuEcjsxuPyRA-zB2idag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Hcb8QCYl_FjC1xrpoa4Vg_hcfWrJ-2hc
X-Authority-Analysis: v=2.4 cv=demwG3Xe c=1 sm=1 tr=0 ts=6a19352f cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=i0EeH86SAAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=zzBG9ipUb6nLY-ocZWUA:9
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Hcb8QCYl_FjC1xrpoa4Vg_hcfWrJ-2hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MiBTYWx0ZWRfX1hcAwn6guDJr
 PNkTliFg1y4Nxu8mv8sqZd4MCByiiKzqhbaLYaWg0e5MGFtc8HZsrRS77QFSG0CgHpY2T47nRwU
 ha80dXnxFdB3QIt+V/SBhCtfKHbPOTx20UpkFWLA4ez6lCbaRRqzy9fPDsLejkRwQAzkxg9Jp/l
 A5Iyvn3JyrzaFmVh1CG0VIDZpoT02SIHtVyy5hFRQNzbVKI3iHCS+F5pLU47LQGjkU8giFnXS6O
 4glHIpb46+ZH07xVOO1cq8rnjv0HhMton8+CajuArdb1e5fs4ptBtiLJ141JEWs3wWDPt/DMEOP
 KOWi1dLkp+wjkGnyMFkCsIAndvl5gb2F9vwVbSF5Wuk7rA5D9EUNsmnlOMZaxusStX0h4hHCS3C
 yDind5S95W7W/x0bZfyIf1z3FwDr8QzSB+61n5vFCjsC4u1CRc82Ci3BKSufspdGY5ECweioDbL
 W0WzCsw530eLu0+pQNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shazbot.org:email,huawei.com:email]
X-Rspamd-Queue-Id: C8A5F5FE11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 1:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >>>
> >> On Tue, 26 May 2026 07:43:53 -0700
> >> Zhiping Zhang <zhipingz@meta.com> wrote:
> >>
> >>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> >>> requester mode without reaching into pci_dev internals.
> >>>
> >>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides=
 a
> >>> !CONFIG_PCIE_TPH stub for callers.
> >>>
> >>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >>> ---
> >>>  drivers/pci/tph.c       | 12 ++++++++++++
> >>>  include/linux/pci-tph.h |  2 ++
> >>>  2 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> >>> index 91145e8d9d95..6c4492075ae9 100644
> >>> --- a/drivers/pci/tph.c
> >>> +++ b/drivers/pci/tph.c
> >>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pd=
ev)
> >>>  }
> >>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >>>
> >>> +/**
> >>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH reque=
ster type
> >>> + * @pdev: PCI device to query
> >>> + *
> >>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_=
EXT_TPH.
> >>> + */
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> >>> +{
> >>> +     return pdev->tph_req_type;
> >>> +}
> >>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> >>> +
> >>>  /*
> >>>   * Return the size of ST table. If ST table is not in TPH Requester =
Extended
> >>>   * Capability space, return 0. Otherwise return the ST Table Size + =
1.
> >>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> >>> index be68cd17f2f8..fe572737b409 100644
> >>> --- a/include/linux/pci-tph.h
> >>> +++ b/include/linux/pci-tph.h
> >>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >>>  #else
> >>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >>>                                       unsigned int index, u16 tag)
> >>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_de=
v *dev,
> >>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >>>  { return -EINVAL; }
> >>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { r=
eturn 0; }
> >>
> >> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> It need add #include <linux/pci.h> at beginning too, else it will counter=
 compile error like this:
>
>    In file included from drivers/vdpa/mlx5/core/mr.c:8:
>    In file included from include/linux/mlx5/qp.h:36:
>    In file included from include/linux/mlx5/device.h:37:
>    In file included from include/rdma/ib_verbs.h:46:
> >> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PC=
I_TPH_LOC_NONE'
>       48 | { return PCI_TPH_LOC_NONE; }
>          |          ^
>    1 error generated.
>

Great catch =E2=80=94 thanks for testing.  I will add
#include <linux/pci_regs.h> to pci-tph.h so the TPH macros
(PCI_TPH_REQ_*, PCI_TPH_LOC_*) are in scope wherever the header is
included.

Thanks,
Zhiping

