Return-Path: <netdev+bounces-270597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKkkK4BnwWliSwQAu9opvQ
	(envelope-from <netdev+bounces-270597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:17:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4362F7D89
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 570C331E26D0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B703B8BC4;
	Mon, 23 Mar 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV3V2DyF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KKvBgedI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A13B8937
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=170.10.133.124
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280027; cv=fail; b=jhj4H9KrkDjBcZPJpzS/FDz9eYh42aQvPR6oYYI4nOSbdZLGLDNaj/FugpNtTOzCWOUs5nO5ePXsxLzLbNfJJwn8vXzDr+0VlY67y/NMvDKxJkhwqOvm/bIPzgxmn866JNs8M9CtwqMEZGAzEyoVz0yNml+M7a8XN24VowQiL78=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280027; c=relaxed/simple;
	bh=X4bct3iBBuIKG8E7BrafoPbfLa4RW/WCp8z8goYZcAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDzc53ZD8BmT3Z9s+O08F4ZuqEI6mbEkTCZYyb/USId644fbXFW8WA0PTlNZZG6+eSJ0bCqaLRLPgaT7fOINxnrB/JRH93+ROyRoJgJjbJtNM//gMJbhdTpTrdD0lwlnpaGCIb05/mBGAarDfWAvfFHN3+6k0xNqweIxVKqmxKQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MV3V2DyF; dkim=fail (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KKvBgedI reason="signature verification failed"; arc=fail smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774280025;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=kHP98ifhmKIzUZQYkPGkWj7PmJKZq1Gq5BCLXBzs6BU=;
	b=MV3V2DyFS0cwKbWCrMdX28vu+4+yw7SKf4uQEGx7OEg+fga9qmEEZaP04fsFAGcfXJL141
	g5ponPbiSUYTg5voBe4HIN5kreLIi1uznbyKLfDkJR/IcuDaeRbsVIgDUS2w+2fRXC2gcR
	ZNwZ/HhZwwPAqmqt94tOuANh251Vmy0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-AOmdw9rNPR6bS2tbGE8DqA-1; Mon, 23 Mar 2026 11:33:44 -0400
X-MC-Unique: AOmdw9rNPR6bS2tbGE8DqA-1
X-Mimecast-MFC-AGG-ID: AOmdw9rNPR6bS2tbGE8DqA_1774280023
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439cbfcfc21so3825627f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774280022; x=1774884822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:resent-to:resent-message-id:resent-date:resent-from
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHP98ifhmKIzUZQYkPGkWj7PmJKZq1Gq5BCLXBzs6BU=;
        b=jaGPS0/QTlTQ9krbliGEDN7M05bLM+Pn6LUEkX6uIt72vr5vEcJhUFiSqDMA7dhqdP
         Y4ziH1D+EFw4eDh2HIpg4Zz/uA7WlOggMbjQZBqFCUmNoIXECRPNaPrF37X6lE2NP+Ju
         B2w7hJ+wV6GTzem4S4rGGKigirDE0+LqsxLpafxn7ImRAd7VysFShBPsMYqnS/LDN5MN
         JFjVDX1ZnSaZoPlQcQRgIoBtUiZ1YLuYVEcy9gcLrgCAgKdw5Cs3MfEPWydvgal4EWe8
         poS/YfJarKNjB+3FsXzVqPHk5YV4GqGpdZJNNuONk5EwRg4Eons+Z/p6XWZ5ch7lyKUA
         2ccQ==
X-Forwarded-Encrypted: i=3; AJvYcCVYaVKsK55O2kpwYnma4ceB9rT/GB9A73HyNhbsYCjvmgD3RuDf/VS8Agu4RYmsrqqK5DaHxSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvlGY4H8F45adNV2LpwhrU4hdkPSWfK7M+i8Hl+kwFPIKd4RK
	DElgW8sZcOVSbJpwYUknMbhLREZ6IY91hZ0WIQRFSLga9FklitQGQNIvRmkqfoQn99VgxQoXnl3
	pwYOrWNm80kIWIfcYSvGlN0Wc96Wp0M5y2GSEof54ztI/o924gMcxSQlfbmxd3xFS1+U6K+2d8/
	P/KVaFAoFBYUc2CvlJkxJclDIiTArUnKlhvJM=
X-Gm-Gg: ATEYQzz1z8fIoGXhSK+OqivNDLu4rBfnIiHW9eo/iCJmYWrS69SkB7iZEQos7AtU/8m
	2LkXBdgfW27elc/TpMLLSHv+vvlZu4gUEsOc87Eh3XxOJsS1hC4dUNR97NlD740uQUipMpH4jMN
	5cig5pJxLcW4k7rG9LWWmZp6b0mVZVK0M/23yqpTrbV8PX45d8pBXu6Q/NOrruLW/Aznl5Wkx8c
	D2xjwA+SNqM+YW/7pygzKfVPC1yZ87SQnR7wRkc55czBGF3MWzAg/iXMvNuXkSqF0MXtqXLqWwp
	wuREesQWTVtRcZtUKQ4GsArRHvxo+oEcJXk7QC1yJPNJq/WnCeYnb8knGIl4yNTaiu7WSbmXT8n
	wXJJsNy+7QES8f23a
X-Received: by 2002:a05:6000:40c7:b0:439:df60:f87a with SMTP id ffacd0b85a97d-43b6427a229mr19367703f8f.46.1774280022393;
        Mon, 23 Mar 2026 08:33:42 -0700 (PDT)
X-Received: by 2002:a05:6000:40c7:b0:439:df60:f87a with SMTP id ffacd0b85a97d-43b6427a229mr19367647f8f.46.1774280021728;
        Mon, 23 Mar 2026 08:33:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm31072681f8f.26.2026.03.23.08.33.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:33:41 -0700 (PDT)
Authentication-Results: relay.mimecast.com; dkim=fail ("body hash did not
 verify") header.d=ibm.com header.s=pp1 header.b=KKvBgedI; dmarc=pass
 (policy=none) header.from=ibm.com; spf=pass (relay.mimecast.com: domain of
 oelghoul@linux.ibm.com designates 148.163.158.5 as permitted sender)
 smtp.mailfrom=oelghoul@linux.ibm.com
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: Omar Elghoul <mst@redhat.com>
X-Google-Original-From: Omar Elghoul <oelghoul@linux.ibm.com>
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Mon, 23 Mar 2026 11:33:39 -0400
Resent-Message-ID: <acFdU9xrNfGsv2Xx@redhat.com>
Resent-To: netdev@vger.kernel.org
Delivered-To: mtsirkin@gapps.redhat.com
Received: from imap.gmail.com [2a00:1450:400c:c0a::6d]
	by tuck.redhat.com with IMAP (fetchmail-6.5.7 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Mon, 23 Mar 2026 11:02:41 -0400 (EDT)
Received: by 2002:a05:7108:444a:b0:556:1b84:e7da with SMTP id
 x10csp1269593gdu; Mon, 23 Mar 2026 08:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=3;
 AJvYcCUK1ixl0BgA6M4F9jcxnr+l6pyTvjNb9pkHswFjgToRc59eg7fW0Ku50MJIGJvf9dvebiKVTIPvQQ==@gapps.redhat.com
X-Received: by 2002:a17:906:f593:b0:b98:458e:2b99 with SMTP id
 a640c23a62f3a-b98458e42a5mr753751366b.38.1774278152622; Mon, 23 Mar 2026
 08:02:32 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1774278152; cv=pass; d=google.com;
 s=arc-20240605;
 b=baLQ2gZw421/Hyz8mSoM1x3lkcVrKbN9jU2RZpEEklW4MhlRzsW698zN7TOAPZZuUI
 RB7aPE2+PPa+sZLrqWSbNp6NHNA0REhVxaHQjCOCRMqW2kP1j7I40vo8U75Ds36nw/nB
 kDcj+yAs5E8tK2efzR/uQglRuEzPstkSWCca3FSZj3VgrxPiRvjeVQjTBtoaGxAS1R7g
 JkvPNe+R3016jPPpTCjKc2P2WxSIuRJXfPCnQtEmTl5T6zy8Z63+tHbZsrtO/XhxuvTK
 86XVX3UsPlYS62UKqoclcWDF34SuSMOpcwk/DZvdBGsYomdQ1PUtSw5pkiv6vQ4PoaFd aSDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:delivered-to;
 bh=kHP98ifhmKIzUZQYkPGkWj7PmJKZq1Gq5BCLXBzs6BU=;
 fh=f8Qv+xUDxdKouv4TSauDrhjtX+zCxDP3M8VuczJB3vQ=;
 b=FpPQ5wx2wFKVN6RVKcgAQ09pg64Q8MSENNgcb7b1EEu5L5xaiDL98PiCNVdNxsAdr/
 N1d0H430dWUi6QLrguHhE0Wry76Tth7Zbg7LHnunY/O+FUoeQlXn9OigZr/9dSLlxFfC
 7iepa2Dj3/U/Nifysq+zlp22SvuAw5JCIje4D4FofZHc30WI8TMJkZ1pufk1KYDL/K3v
 62OXhvZH1flHH5hHYaTat/zfUEu8pxsyO8bCNoD412kIFUPQ5aY3BCMjFtJxB4uPQLT1
 f4KllOf1AG6ZHgeWDMMljF6xaXDZAPaqm0DITAIZ/g+UhXIYrwDFM5dLZCaCqpdsB3+x 52Fg==;
 dara=google.com
ARC-Authentication-Results: i=2; mx.google.com; dkim=neutral (body hash did
 not verify) header.i=@ibm.com header.s=pp1 header.b=KKvBgedI; arc=pass (i=1
 spf=pass spfdomain=linux.ibm.com dmarc=pass fromdomain=ibm.com); spf=pass
 (google.com: domain of oelghoul@linux.ibm.com designates 148.163.158.5 as
 permitted sender) smtp.mailfrom=oelghoul@linux.ibm.com
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com. [170.10.132.61]) by mx.google.com with
 ESMTPS id a640c23a62f3a-b983cd163aesi752926566b.276.2026.03.23.08.02.32 for
 <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Mon, 23 Mar 2026 08:02:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of oelghoul@linux.ibm.com designates
 148.163.158.5 as permitted sender) client-ip=148.163.158.5;
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-rUXDrxbwO82wl-YM1WUpXQ-1; Mon,
 23 Mar 2026 11:02:30 -0400
X-MC-Unique: rUXDrxbwO82wl-YM1WUpXQ-1
X-Mimecast-MFC-AGG-ID: rUXDrxbwO82wl-YM1WUpXQ_1774278149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 5C39E1944DD4 for <mtsirkin@gapps.redhat.com>; Mon, 23 Mar 2026 15:02:29 +0000
 (UTC)
Received: by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id 5758719540C4; Mon, 23 Mar 2026 15:02:29 +0000 (UTC)
Delivered-To: mst@redhat.com
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.49]) by
 mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 531321955D71 for <mst@redhat.com>; Mon, 23 Mar 2026 15:02:29 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com [170.10.132.61]) (using TLSv1.3 with
 cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits)) (No client certificate requested) by
 mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 B5A8A1954B2E for <mst@redhat.com>; Mon, 23 Mar 2026 15:02:28 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dkim.mimecast.com; s=201903; t=1774278147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=kHP98ifhmKIzUZQYkPGkWj7PmJKZq1Gq5BCLXBzs6BU=;
 b=J8dsfonT68KNYr9Pky/oWJIgKLva2NGWBG21U60TVYsBF9BM0oSFv1QU/pGa5h+B2R1Kgp
 bkOBbiNMRLaXYNbLAiCuOFYNqAraaD/WhY3hEbDfTXDuT36h0Ue7EoAH5Pa9WYmboEh3vx
 QGwmYvtmhtRgJG/fwtGGv6h3406Gc9hrtk9xrG2LuJoibClayPCEBswbrMqqxSEWrWyY9j
 mnGsei6tHCjIzCV/1rtS9zhsRm5MroQFyHw9Tj0tMqYSl+mp2Ek7S6Jh8ls0hmoysSAQqP
 Ugqt8NNS8uedtHwVq9ow+XLzpQcHqUNhOJGqXDWGQqei+khMN7eVjBOBddDAoA==
ARC-Seal: i=1; s=201903; d=dkim.mimecast.com; t=1774278147; a=rsa-sha256;
 cv=none;
 b=rFAZ3vtzMVMRGW9vktx0CSsMUH6QRCoeA6H5551WE2kMH/Bv5Hz75LBBwyP0zgmMcZ0/vV
 E2xTtWa65W63ew8qLuuTrGGv/5VKigDVCg2y4r2pNl82NGQgfAdQsrimqI2IpMNH6d04cj
 NQcoSpUUWUUUQ3fLVjhJLE5KUfGhes13rAqb0GgySApdbzuVRU7hq8S7d4vjOasESAqoc0
 YiXplY4ceihFGrj5Jc4uNmLzu5xpJXn2HzuDJgKyuAUwL/35GCMcikNBf5AI/hx6TDQUlT
 7kGEtLbySOlSx9vIPR7uTe4BkVUQQ66ihY8Q/690UpPeToMnS2ELyqs3aL2J/w==
ARC-Authentication-Results: i=1; relay.mimecast.com; dkim=fail ("body hash did
 not verify") header.d=ibm.com header.s=pp1 header.b=KKvBgedI; dmarc=pass
 (policy=none) header.from=ibm.com; spf=pass (relay.mimecast.com: domain of
 oelghoul@linux.ibm.com designates 148.163.158.5 as permitted sender)
 smtp.mailfrom=oelghoul@linux.ibm.com
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-L_hZ7DUeNb2p7tibGAzcdw-1; Mon, 23 Mar 2026 11:02:22 -0400
X-MC-Unique: L_hZ7DUeNb2p7tibGAzcdw-1
X-Mimecast-MFC-AGG-ID: L_hZ7DUeNb2p7tibGAzcdw_1774278139
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNU57e670670; Mon, 23 Mar 2026 15:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GLL1Ly
 3OeAkM26lTyfuK59J2i4l+t5B9XXC/Bq7VyJs=; b=KKvBgedIntUMFnLe+in10/
 ShGLogvTap51JQ+yqi0eVYJzFjLO10C9YUq0WmFwslEdPlllrjtErFvtEFChT0wa
 ZRcG3JmkJWEbl1d33WjE+EGvvA7JxSOtWikN4Nqj5jQFRQuGkE8TTZNiUnuMXzHw
 xAL3NeM6zs6ZJNbl9kSr9oAm5XudAk/BToX1ixNU2dE/iQjh0ZfX94+R/zTpLGPz
 JGOzt43Sd9p6bC1FAml/1/ZlCY8yv22ZJXSiwWsyCwv3hnVmxnIPzdXUE2erWS9q
 /M5HAjVS99cEVGC0IXcp7OzURinRW/ppiDuOTAQipjb1mbuCV15QMQDla3oeI59Q ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93]) by
 mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuq3ee-1 (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); Mon, 23 Mar 2026
 15:01:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1]) by
 ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCruMC026771;
 Mon, 23 Mar 2026 15:01:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70]) by
 ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275knqtw-1 (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); Mon, 23 Mar 2026
 15:01:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232]) by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0)
 with ESMTP id 62NF1RmQ29360808 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); Mon, 23 Mar 2026
 15:01:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1]) by IMSVA
 (Postfix) with ESMTP id 42E6658063; Mon, 23 Mar 2026 15:01:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1]) by IMSVA
 (Postfix) with ESMTP id 51E1C58059; Mon, 23 Mar 2026 15:01:49 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.188]) by
 smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP; Mon, 23 Mar 2026 15:01:49
 +0000 (GMT)
To: vishs@meta.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dw@davidwei.uk,
 edumazet@google.com, eperezma@redhat.com, ilias.apalodimas@linaro.org,
 jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, technoboy85@gmail.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, oelghoul@linux.ibm.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
Date: Mon, 23 Mar 2026 11:01:31 -0400
Message-ID: <20260323150136.14452-1-oelghoul@linux.ibm.com>
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
References: <20260310183107.2822016-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YNzfoRIt1da90gDrXm5OnayrwaK83DCr
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c155e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bD6ukYfIgYhu4hH-dYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfXx63mzxnELWk5
 Y4ei4W1R77ANzeQcp3sM/IdvojFh1xZob0caVE4n47QoppYM048+qJ2ITChKBSjII++GBT3OduH
 FgKkCoVxgd/db9ymu20dPIn9V/fyFxZfEySwE7z7hPyZR7l5xim0s4c4dVCS+N4BKVnI0PKq1tu
 Q3VQWOb3aJI8NTpl0kqw2nVIfI4hH6gS0tAJE+FsJSdcnGj/vEHnHX9NDmGpag2zyjCd9wBIjTE
 fhXgeZWkW+1b4vyW4wli182xMcnpU+FO4qTWf9OumG1AmNrAySfCqOPfmEyY59nOzJZ2u78X1Gx
 I6XRcQvrlpEGEqFM3P2lTFIVTn9VhSM4BgUrpwdcKGDc2GQzwp7UwpwdFBViTmSGMeMWni8GmZb
 /2ruwN8yuID2OV1fr4NADUTfUJFtlWYlHu235M+UQXNnadxH8kilKOKn4kO6vGzuVpUVYQbRz18
 7oLM2n8sWdX/X/s4bvg==
X-Proofpoint-GUID: 9gD9_WOZoQLsJS8lan0dhb2SdmUj0w89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230114
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 62MNU57e670670
X-Mimecast-Spam-Score: 2
X-Mimecast-MFC-PROC-ID: yBtnEdeN2-qRS_8RwN-A2v8dOKEychym13QMC4ypmuE_1774278139
X-Mimecast-Impersonation-Protect: Policy=DMARC Check - CHG0118091;Similar
 Internal Domain=false;Similar Monitored External Domain=false;Custom External
 Domain=false;Mimecast External Domain=false;Newly Observed
 Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to
 Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
 Dictionary=false;Custom Threat Dictionary=false
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[ibm.com:s=pp1];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,meta.com,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270597-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_MIXED(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+,ibm.com:-];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F4362F7D89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I've been testing linux-next (tags later than 03/17) and hit new issues in
virtio-net on s390x. I bisected the issue, and I found this patch to be the
first buggy commit.

The issue seems to only be reproducible when running in Secure Execution.
Tested in a KVM guest, the virtio-net performance appears greatly reduced,
and the dmesg output shows many instances of the following error messages.

Partial relevant logs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ =C2=A0 49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 t=
nl csum 0
[ =C2=A0 74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunne=
l 0 tnl csum 0
[=C2=A0 403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum =
0
[=C2=A0 403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum =
0
[=C2=A0 403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum =
0
[=C2=A0 403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum =
0
[=C2=A0 403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum =
0

Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
   enabled and a virtio-net-ccw device attached.
2. Run dmesg. The error message is usually already present at boot time,
   but if not, it can be reproduced by creating any network traffic.

(*) This patch was not tested in a non-KVM hypervisor environment.

I've further confirmed that reverting this patch onto its parent commit
resolves the issue. Please let me know if you'd like me to test a fix or if
you would need more information.

Thanks in advance.

Best,
Omar


