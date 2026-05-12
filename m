Return-Path: <netdev+bounces-287176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKGRAPguA2qN1QEAu9opvQ
	(envelope-from <netdev+bounces-287176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4552188B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEB19302EA1E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66539060B;
	Tue, 12 May 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ULmquoS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC223E1730
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592794; cv=none; b=LGpivVvkrCb4UKFthbkBzs/2LzP0gBLWYvWsale+IhXhLKcnpg44uSCp742GDqQJISx8Qv74bO8YnPztZA3fMW1GyvQGr6EGJAyb61pSAgXDloH8IH2qcWnBHL5MPrpnnjqBen83OLOA5gdd/h0w7ogAh7PiE64rVh7CsnXdTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592794; c=relaxed/simple;
	bh=ulTqOnJ0/DOZtfwfiFl6Nx8CEJn66OQ5TqF7AqphWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRpv3t9iZH8vU212ed9sLOOX4mplBIHE816t/WhhB9twr0Bwurg6jbUcdOaxHjpod/PUyMHcQxMPcmgZQGxpOBDWKYuQw5Mq8Otucn6NYw/BdBFguwjj51RLlMVYlV/9z/UZxBayIaQ3/3irE8/bsqXGWVeBP0aYipxfRjKC/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ULmquoS7; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2bad6226d1cso3375165ad.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592793; x=1779197593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M43xE3rgAlqZemGJ9rIPU9yoPZP2zJ9KSuP357iBUFo=;
        b=Pxp+8SQB/iCE2f2HQD7/kTgo/Da7pVs3djakasj+M+FqyBWTeYQqQ1coD1G+LGh/jK
         3JIKjgxmAtW5mthpKw2lWZIEVPG+gWR4GExFv+W+Mosi5L2uwsefFwMEYVX3tGB+sF30
         zHBiw/G/ZR2sPifz2UWGN8n/DtgJb/gYjz5l+taHL/+Bazqe3pDlAVZLEFSEwUtfEy8x
         dbT6HhMuUU7PHZPj6C4MOIJqAL5O6WmTYaFqXJaIiivvZpIPtxNqeooABtc2O3vlrKCG
         n5k8fwFaiiS4X7o1QyRf/pLEmjYuzcKIkka9CTHoeSXDIn198qZCukRo3RwZFFgmlUQe
         eCNw==
X-Gm-Message-State: AOJu0YyFgLbqVbwbVikcbIm6sSRsrfZtxjPplwTrolkh6rhKwXJr/ZzZ
	VhcGJC/X+uYzNO/PiZHI1+dOt1t7U+B2YfbqqSoi3xOn8S3AsJtJz4GQUVWD1bCuXS1i9Gap1C3
	SyhkIOlEh1sDLQteu0kWhcgGy4dRddlXAaeSF1EQnE4+/0QN97WlyhJI7ezBP645tp6U35aiG8a
	YrgY7bLQzcbAukmMoyfwUiJnoPB8rrraAB0Hqc06P1su7aei0WPUYpRps7inPXYQUQr2gW/oy4z
	B0VBXZh7q/n
X-Gm-Gg: Acq92OE5g3ZhfVSLKa6gVH8MGQ8JaqXEb67a8aUMXQyRT3vM9EYJ4afIJesTjF4vm9n
	BX7XBiBh2AmNrekFLtjg+JiDa0EpuOKrVBtAgGWT2liMVaZxDOC0dq7b5iGu7+psQND4quP2AbM
	fL4JKmN/uK3M0781Sa706muauy/FAdTnrEaIC8jHz2TY/k8J0ZWVtKCRNNZO49aYyDAraK43uo/
	fmRQGzzWevGNdXTtd+2pOErwtwqP2DFbbVTVhpJHel9vFZz1g/8BWlODYxSC/VktoVAcdU3qNEE
	vnpYxfIvzYR0tQF6HnjSmDECYBKja4kDd7GAcSr1jnUr3Ai1/bWcECevMUdQqmYmW9dd4nRs9Ju
	cuQDSJD/bB4jtYRD0EKoUe+5k63UQbE++TorSKGqU7rmtvxmkET0u01FcMTzo+KSRjVBlhgNv80
	CJTMXQ7USOagoAM8E7Tq4y4N3AbhwbGC6W/q3DJJutY/HwyqugTi7ujs2Aiw==
X-Received: by 2002:a17:903:4b03:b0:2ba:2333:8a53 with SMTP id d9443c01a7336-2ba79c311a8mr155615795ad.0.1778592793000;
        Tue, 12 May 2026 06:33:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2baf1ead51dsm10208835ad.26.2026.05.12.06.33.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 06:33:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f5145cd327so1021799eec.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778592791; x=1779197591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M43xE3rgAlqZemGJ9rIPU9yoPZP2zJ9KSuP357iBUFo=;
        b=ULmquoS7rMWPZo7vHyWDcNZRYD6tgjyATBRSU3TiwbHvRA573Lxg+q4jHumSdNVBpT
         OpnjT335zJFR9C2oT7GMjt7NB6sqprnqLPNN0jxaty3b9uOhxur7eJVtsFGIBU4vzWEr
         jamorsAEgJN7CG6oT5/LCMEaB9XSrne4tDvBg=
X-Received: by 2002:a05:7022:6992:b0:119:e56b:c3f3 with SMTP id a92af1059eb24-13203e9654emr5811842c88.3.1778592790466;
        Tue, 12 May 2026 06:33:10 -0700 (PDT)
X-Received: by 2002:a05:7022:6992:b0:119:e56b:c3f3 with SMTP id a92af1059eb24-13203e9654emr5811823c88.3.1778592789838;
        Tue, 12 May 2026 06:33:09 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm22957383c88.4.2026.05.12.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:33:09 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH net v3 1/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Tue, 12 May 2026 13:28:12 +0000
Message-ID: <20260512132812.25147-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANn89iKs3KLo=5hhUEH8OEG8p7_52g+fsrwYYNW=GzP+k7WW-Q@mail.gmail.com>
References: <CANn89iKs3KLo=5hhUEH8OEG8p7_52g+fsrwYYNW=GzP+k7WW-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: DEB4552188B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-287176-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Eric,

Thanks for the detailed review and explanation.

> Applications using SO_RCVBUF with tiny values can not expect kernel
> behavior to be stable,
> since rcvbuf management depends on metadata size, which can vary
> between kernels versions/options.

I agree with your reasoning. Applications locking SO_RCVBUF to small
values appear to be the primary trigger here, disabling auto-tuning
against modern metadata overhead.

> If  a kernel change is needed, I would rather enforce a sane sk_rcvbuf
> floor when the MSS is learnt
> at accept()/connect() time.
>
> ( TCP_SKB_MIN_TRUESIZE / SOCK_MIN_RCVBUF definitions )

Enforcing a safe sk_rcvbuf floor based on the learned MSS and
TCP_SKB_MIN_TRUESIZE at connect()/accept() time is a much cleaner
and safer solution to protect such applications from SWS stalls.

I will implement this approach in v4 and update the packetdrill test.

Thanks,
Ankit

