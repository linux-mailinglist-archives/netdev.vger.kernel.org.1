Return-Path: <netdev+bounces-292023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K3nEXVAFmqcjwcAu9opvQ
	(envelope-from <netdev+bounces-292023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD725DE130
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A317300E268
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CD29AAF3;
	Wed, 27 May 2026 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfUsYgbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5C288C30
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843186; cv=pass; b=Yy01OUPiH0ViXak/5kutDUSxNh90ZAs6uUENPUMyjm9S9khadLPcfjZqQSnIxcWmbZKgaqNIc6cpUZFbV3IzCjIRD6fF6E0hdVeRps/Cepl0riMOLvji74etWV0PhlZHj6YdOX6i0orrOso0cutZfoir9LJ3H+a6nuWnd6Q0EUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843186; c=relaxed/simple;
	bh=/esISb0a6/GGltUROVXYrwUEcLnOf315MU1CqmdWxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzDubqCFsA9nIpkAltB2XTnqc5BIuE5HEHLEoEGwwjWr/u3ffnZAdNB05WZgePHPm4Z29R/IPAAUzL8slmttbmsgfImTIAqEQ+FXQXteGPz68Sn96htBwNtN9ckJu/twOcNxYLpuXzeBK7cXY27djJBljwShGr27Cp6HTjM+HNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfUsYgbq; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30246cfd41aso1215776eec.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779843184; cv=none;
        d=google.com; s=arc-20240605;
        b=Gd9pnbr/okiM0y2GWOVLQFfwtH6L3C3rddGa9yPOLCCAkzmdWy7n4y0gGMDhcdWXkD
         08LKjgMrkGWJM9Xe5ar/5kJITmQgHMQNRvqLvezTCdOmThF3r2DbKZaRWA1AyjIOcabQ
         GxsG/UGcLGuxggCqca9J+lgqThfLfZuABpaU5QaIT3MPlnphVOBNAFcBAErRkSK/a69j
         3m7cBZH1qhNkY7jRtq+B2MTHK248FaBalr0Z/4OvRv8jVqCXgA0/dwZ4VBbvmJzlaay1
         JcF3HQXFVyLpmlUqHiqHlG4Squk3M+U65vNZBRsbRGwljTzeCAbjnctPMWnCrGBCNJVt
         OeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        fh=6ATGn0R16x84G6tCn7YdEoz5qWlJezXFo4CkYZupPp8=;
        b=I7H8IT1vHCcDyZLkMAz3m8+1/pOCq/453qX29fSVOoA4VbkZw3WAXxWGGUgaG9mBF3
         2NbgEnZvDRLLn6pP3AtwnjHkpB4PcUVeDAZbqdVRpSXRnyQUGTT1TCHgecfgjFlZtgy0
         IVRVSUxRZ7TnxbMB16ZmpyJqAceZ5Vw+QrmtdADAsNaLhivnUtRSAOeZNGfVcILn3ueq
         1hcfR8p88IFDSTeWr1YOyAFixhlT+Rd+z9i8M5W7VWWwcaWrM+YNx2VEjgYJCdc5WkSi
         HNLH61oDK1CglvXHT6lQZstPrgI8McXiF03mxRJqqUDuZ3WizuU4BP9ZQmdSKMh32Wj1
         35gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779843184; x=1780447984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        b=LfUsYgbqSeStyT25vpCuph2clvmjUXYxQjeOLTFZ6rsjssPRKZfM1mYNJrxCnM0X9t
         LkHs23yXjcgOwpwLuhldF34aoy8UJFXFh5gE8vwnkl9n6/za5XD6N9Gxy0CY3opm1+X6
         pUJRFuJSHhZEEKk0ZwwefCnUHUI0AvIEmWLL9V9QzkZMNhWEqOdyrQMbMEiZq9ZZJDf5
         +KW7vyox/csm1C/5G6BgBzE+bFtZNLs8k7JHaDSH5NuB0mrxTg7uNpyWzB/mMEiRVKlb
         Axn6S+S6VFIcmGZXLgP1XZyfDVsIZmfD0EbKMqSVw8VzNa+IvcLLa0XnEn2dJYxuhI+O
         FTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779843184; x=1780447984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcbwfShk68TwXkrE3Y+HrrrNxmqrDdo7ws3A+Wa6dFM=;
        b=kjUkDDI31sucZ7V55YOHm7VbnN4cm/m4pLXF6wqx7xTwZFRXD5OCXS1C/IRe9rB/k1
         RM13+5/6UiR1g7C5xBSWOCC6O7tfx2FtpNThPIGnUG1c7kOAdHkWgYYzbyzwKZI+wuGW
         qJ7DI4d/zrqyATpf16HYXikVkdADSUeYfxkOWZ1U+YdZ2vk9LjH6WBFk8pxxy1Y82Hcj
         fr+VHI7uVklwSHSkKhogpDpyVq17qWVkuhfc2HUM0+/iF/v3gSG9Ql39wEuTSOSpcC1a
         69rP69rU0dzIWmZjCAZ9S3oyGB2UAwbhierzL15uZyfq47/L3DCNJOlHw16vZTQq3lz7
         LSYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pqsWTVMCSjR0y9COXy6nnKAO5MLSk3DsIKjRS0AlHn2RdXJBBaToQjWxmPMb8zcuP54qmd6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrxZkGedMAVJb4wcTHahATqPDGAEgLk6HGDiIYe2f4m48fRCJ
	7hq0gwFBv1DRWJpmk0w3eQ8SIExHEShtS0JNVVkpSx892VSLbTQZGx0OWq6DFxNpED9z+f/xbay
	Wlqog99KfMZPBnGfDCPZOfU4cpYIbePlzWdL/TXS8
X-Gm-Gg: Acq92OF8LZY1K3g8KXwGvFgQkC6+qrGw062CZX82gdpT1pxuZ2BbzwUsylFrTmrXhJ9
	aF1FLoJ1wclO7l2XKE++F+yzB3dY1R6rRK4lUWdXCoepEPIxBK0qXTZhgvHumnke1pvrtLlZJh4
	pm4cbJ7L4eVAAJDm8OIo38dx0i9+fq5fHGA/PVTkct2pk/imKB+S1ERCsx4NOraH8zo2oysH4rM
	MvcjZtyeFpRTbF0a7f5PtcNSwoHEDzIwCUmcVVxCHThBcYBslBYIOKEqJCOkYEfQQUEjnfRzIgO
	eqtv4zlQbvOfMWAEXNT15F4LpzBRFkteiW/z9v+DRptjIIfZZkkCBWC3AAmn10gWPE5DndiuI4d
	gd6yIN6oGRSNH21UzJVFMXI/u7Jm8kj0=
X-Received: by 2002:a05:7022:128a:b0:124:9dea:188d with SMTP id
 a92af1059eb24-1365fc6d615mr8591681c88.30.1779843183792; Tue, 26 May 2026
 17:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com> <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
In-Reply-To: <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 17:52:52 -0700
X-Gm-Features: AVHnY4K2vO29GyKK3bQJPNlMMEc6xFAH60H1WHHv66s_2zPps--4POJYlI_4jPk
Message-ID: <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>, aws-binance-tam <aws-binance-tam@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292023-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,readme.md:url]
X-Rspamd-Queue-Id: 9FD725DE130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aaron,

On Tue, May 26, 2026 at 5:25=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> =
wrote:
>
>   Hi Kuniyuki,
>
>   Just following up, were you able to try the reproducer I linked?

Sorry, I didn't have time to look into it.


>   Happy to help if there's anything else needed on my end.

Could you try reproducing the issue on the latest net-next.git
and/or the latest LTS tree 6.18.y ?

And if you can still repro, please update README.md accordingly
and upload your .config file since I don't have access to Amazon Linux :)

Thanks !

