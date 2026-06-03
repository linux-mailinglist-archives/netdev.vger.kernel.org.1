Return-Path: <netdev+bounces-294842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WhvvLlNgIGqT2AAAu9opvQ
	(envelope-from <netdev+bounces-294842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1394663A10A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=g5H2IGOl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D9A312348C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2A425CD0;
	Wed,  3 Jun 2026 16:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B6426EAA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:46:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505180; cv=pass; b=Bbfx/P3+bX4iFgKU7niaOP85DxAEuUBw4ImkqZW31A8Xxgmdf1UA5Y2Cko5S9MLjqdiGodThmbqf6KPKuJ5NFwfP2FwDqhkv5sBynGrU/J2+tXr4QvfNRjCW+zQyOzNtKlhYdDPYYBJVQ4uAm8J4lenCiFaFzuVvIkyijHTwT9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505180; c=relaxed/simple;
	bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCkNR1vyyWRbmzjJriZVUNueXVYLIO/H9ity033e2fQrNWUZT4781mdN9NA60Xj+KlekLX96oTFDrccWbM2mDP8hQgcN1JrhJTpM4cqzAOEgJfQ3wkd00a8trzaWHvKwfEsX6l8QUNsAdxcdWANuM52Mz4MCITSVgBSTvdL5Ytc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=g5H2IGOl; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f1d8902so1648674b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 09:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505178; cv=none;
        d=google.com; s=arc-20240605;
        b=QvWypOSQSreTPGdndykHhfrop09AYZFpcXl9MljYSczQWulB++fmqxxiJg+1TKPhe4
         KW54Qq3iAkNzaSDCTl7RJ1AIktHb5xMaIccYguErcVQYVDN1t2qJfhZ+MQ9I9d7KeAeB
         /72CSz4hIk1a6/sDPPOybtnkcHPbC74sVenev+ZedF6c2MmnJb/Pd9Fcq1alEh0bQEIG
         pp70LzNfruyhnpkGEYSmjps2ChReUtviKr0TqSFqIdczOKvGtFL0sDcWeXzhm9Q7DPcn
         1dQvcDLQ2fEGeZvoojPnL493plBzto91W/L3d8Ipd8y9/OYO//1AEQpvKn6ZON3oW7jl
         5UkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        fh=xnvsta0OM//U0vuk3goT8tRLN42Ya9BNqqC0WsOuSWw=;
        b=aPlNTzBC5n8oI3NYGovJAU5yRs/4Pf/EwULa1YPL23Fp33Tma35oDyPOeV+PQ0pO9q
         dye6kN9TBPwJ3RbjGWl6ySxoMUMCuQh1/mCebq/R8wwWBe2BXdw985hWdCIBm3SFND3+
         s5uwOc7LxYgaAMNIzE6Zc5JWN0JK0gMuXuxtYM1u8r92op5NVN2k6q2l5nW0D0KCy5wF
         PHvHNw1sPN0x1+UyR/pJleOkefi0W9+DEzRDJPc9cLVnHS07zYGQh4xizB74LVttC+I4
         wC+v8nr4QD6gdgpKE+FatxFjVaflfRGXcIjxRM2GOWOdjyU2/1OXGWTO7q/S5u8TYGYS
         NdxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780505178; x=1781109978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        b=g5H2IGOlFEp1b0RLhwnJZF9eCEJ+q5Dx1yXF4vPWLYSFhMU7NSAh5BhhVuSxeogr27
         XoLaaBo/Lm/rHJ+OvTXZSwjLnGKkDEcc9umGylKIWay3Rp+1OWqt8A962+QGj0s6jXbG
         KyV7h632oF8doijMtIcLNqP/xAoURi3Rdz5TIL2FG+7CoYIo+4QO0qC1qiuxhx+bbnmU
         cwkVjfvgvaZu2OHCm5RiI15kq/Iey8FaewGkdgRkqPrCf0XonC8K4q7wxCBeHR0UTxXa
         jDEDNhW8g+tplnXGLgjvH+r34Juh6AHabyqYr+3Yz57Bl2qphRuj8a4LPAbPG0RfXen5
         deHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780505178; x=1781109978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        b=oWTYKZEamH0iIatAGGcWn6I/IUkY9h+qeN4CGxjDV71Znc9bKfmeG1IAdWMcE9IlqM
         rOaCxl//WVuZUPRLqAHOtcaX/UOcNzdcCNOSL/gzGvyGL9hj1en5Ig7qoikpIYETIWXu
         yKfQcs6gL7X3g4ik6yhA8D/qVVyzqEOvXc2phj745rgw3NF7s/O34gRfe6blYUHwk2uN
         LZnR0qxrT9uYGg0N4ClUkV4xAkNcqLtaD1OQbEX1Emp0s0IVcU6yvMSxWrB7UFlGq/4s
         mov1Xm6IHo+e4yM1w3CTkDtrGqFx++iScj571Uz7WkdP3Agi3SbJn4Mw1Rr9zwOr1YTN
         PpPg==
X-Forwarded-Encrypted: i=1; AFNElJ/SN4ZNp8zxCtrKhoP0WwvQc/t8roEZ04NTMOURJtwr8Y6ZeR7bvPHGhIF5H+9I4OplSBlLzI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQdzsT+rUuH0pm0d8NPY53oE9X7i6UjPDMATNJaxwIVX6QXfn
	zOP2tFITM2lBBFzlfxq20fx5s9GUPoH7SyAzopyx1Bh5DN+A/ijggvB++jznlS7ZdBu5s6ueHxT
	gDmjAyRmqEvVr8idlMssRFDBPD/Hk2jtev3q3Sdzz3ac=
X-Gm-Gg: Acq92OFjPop11hwf2uibjbZ9qCuMso62BnO1YJ3u58zBOpdAtfv5iJ9FIMwkPY51U6A
	qKnDXIpZRLQN+xNvxBVpRCLDiRMiltnumUBcAGzj9FZCh8pFNmjRi7lR7899bsJpCmy+Y5S7VMk
	jma09IYO8DTc156jtwnA5Rr10gqQvB/MlEGn5p61OTSi7G4vrnYgi2TXAPiOoIKDko6DYfiu17U
	WIBOAbzY/ur4XcMQx0Ptu8zH92UFYL8ecUtCgP++nf80CUZvJSEYcDNr/gLZv+vg7VU4Sy04bOD
	Q70r/bqqxIST0+qTkIPtvM4Zdk38ikP8rD6Hg3WU7qoQtrYynduPqCzfL6h7nHXFFgxVhZh0Drd
	/f6MyZQ==
X-Received: by 2002:a05:6a00:2e88:b0:842:1ffc:55b4 with SMTP id
 d2e1a72fcca58-84284fbcdc1mr4542715b3a.36.1780505178146; Wed, 03 Jun 2026
 09:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603141355.68156-1-doruk@0sec.ai> <2f3ea9d6-a483-427d-bf81-ff26627f4f1c@intel.com>
In-Reply-To: <2f3ea9d6-a483-427d-bf81-ff26627f4f1c@intel.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Wed, 3 Jun 2026 18:46:06 +0200
X-Gm-Features: AVHnY4J6gY9pqDSXMaShzszHsJrbvb7KD7f_CAT036a599QygxqxvS8l2JPk_5A
Message-ID: <CAPdMp1r_fPeqHC9LeEek2+u9JMma_h+qtg=CoGs5Gpp+QL8ivw@mail.gmail.com>
Subject: Re: [PATCH net v2] nfc: digital: clamp SENSF_RES length to the
 destination buffer
To: aleksander.lobakin@intel.com
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294842-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0sec.ai:from_mime,0sec.ai:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1394663A10A

On Wed, Jun 03, 2026 04:28 PM, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
> But I guess it's not needed at all, we can just silently clamp such packets?

I agree, thanks for the review!
Doruk

