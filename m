Return-Path: <netdev+bounces-307684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qmdeGJ06V2r+HgEAu9opvQ
	(envelope-from <netdev+bounces-307684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:45:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D96AF75B8FC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:45:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="UBi/b4iq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307684-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C74315BDA6
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63E3C3791;
	Wed, 15 Jul 2026 07:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C709197A7D
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:40:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101224; cv=pass; b=uQJJzdszwmh2OI84kqnhvNQATL+o0pbTvzlCe6olxFep6b/zAeOVdFM3PJ+bfc0CZmW5UiWjkfY/+ZJz5reNx15jEpB9eIyUzIrf9IGaN1W4DRkILeHYFDZh//razWvHoxpka1scKStbE6vOD8jDtKt0omgq7XjpGAa5CV9n6aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101224; c=relaxed/simple;
	bh=itAFmdwV0LJe1R7G2BPunnfcyEOW+YigWSuUC1X06Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaWemrjJZxDsldXoyYbLkmsBCjyYXZbUIdBwMUDV8qyg4ZSdVRv3TIaCZfG7R/NO2mjWx199/i4sceTy8DJUcSNxnUvzAwMt+7pWqfmhokgyupe9MEDhWrtE8rLceB12ouniF7t8a71J6tL/cIXK7SZ7BWWkuLucMBUzyY+mKHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBi/b4iq; arc=pass smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so9241157a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101221; cv=none;
        d=google.com; s=arc-20260327;
        b=ISYYxzN240IlNgrm6awHQPbJk4qLZRyekoowirfXAdPwKlC6zT20Bnn9I7vfsV9hI3
         pJk8zFno1+KnT3aaTJBtSnSDooS7luClPGDtwOEtKc6FxK06pBdcJ6gcc+KhO66UG5y7
         GASl3Bk1xI7vM7imHuCp7u8cNUZQnEH7YncIkPsS/Sa7H7MAGkph3c2jJpEzZbKyHeGM
         yT6i+Lsd9tsUIxdxDQvxUYcdxNRmHYuOng7eBHpgUvAZfYtDvQQTet2Rx0nT6UOfbpOm
         ZzopcrjjiBkWSxei6aWZqg+4KfTIxyzlATtsrtlsOujzIQGpGKxua4/KgnWOhMDYfnsc
         Vpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
        fh=eMBaa78yJ5kzutoNfjQIHkH6dH1C8bhkxzf8mOwoPPo=;
        b=djGxCoQMCoRtlvGtXu1btU/7FbDnCUyyn1xHNBSvzFy4DC7FaURulk0q1kT8swrd8f
         pfaSmqWAjPfKoPXp6MBh/tRf7o0vMiu1A40Rram++F+gRTVWlMQg9uZUXi+pH0p5+Vk2
         zEnBu2N/6Go5lFXca945JKMIPBTXdlzGKFZaQCjHQShVRv0Z8M1c1nIdi1EpCMABFnNa
         fNAJwIb8PelXDIx4DSawULp7KHwtB1vGMtz9KzBszrnm2w4i2RgsTKVfY/WOpxrz1R8m
         2jG0EZqzFduiBj637vTteDv6fUCAWb6xBarKiWChTQwofbnczED5orLl+1DIaWtFUeIM
         VZnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101221; x=1784706021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
        b=UBi/b4iqWB7iKBCxO+WrQik2h7guidhJEjm9xsQ0O0HdG/wLgxj02cxdb/uscLOW8p
         qgMdoDuoNO/2zYeT7+2X/10biJLYp/AfbYc9kUDZU1x/3dZdHK510co/0VQnQux7nNwt
         S5I2AWfm6Nz5xnw+XFgiCTnXbFm3ZRMCWAxmXVlYTbaoVToBf/9KUR+cDJf2i3Xg+cj+
         eSRyCbGFuVLTV0LBNHuJ8EmcegxTEGcnT6jRofLop7X3HneVtCCxfGOlq6g9DxQpZoDe
         m9pj9MxdhONod2EqVwzngoPeAFuIviv7WjzsV/g/cWGCEBQrPLwaU/sfE8v17fbFr93v
         TTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101221; x=1784706021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
        b=j4wWgiiMdiDAgRkUo5EkiyJTrXvQGubCpYj/1wzyLxFtsplSWQaWha0Zk/EWvcmDZ7
         gr+i8YUsCmItlrxdWFxsC7A1KQTvsSAb4WyzGvZaN0hUm2Ig1jzFfRVqO9c1kmRWOm8+
         dqIOkjVohXl0pYahWGha/4JzTP0W3bYi1G/OI9RZMW9NatA1j4p6c70+rhaVA3z0hMc1
         MEAf7hyxX/Ry7YxArNDGbkGPsVRdtCeUOdWdqjIf7l1Fz3+PS+YrmZLUoJFZamvTgd9v
         aUStqVSZ1FrLtrvZAC+qGztZiKDL2hGlMVYbFRD1yQIvPGcKppu3xyuZsbd++ITgDJIC
         oa9w==
X-Forwarded-Encrypted: i=1; AHgh+RpQ8w9WbHtCP1p625SXxl9LT+kQ5tapxZjh9SDpUEhgJoUsm0bhL1AiAmRpkIGqGxgB/9Ta3/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1EzAlJCV+YMI134awfkWr4/nrA670G1+Ubz5m+KZrHTJws4Z
	umT3GBUPxpgsxHyZyABSfMwhOiWADYQ+U1H6lbNkiFAzO3uScMV7q2Zc8jdpMJtUPoYiZPc51p4
	HuupgLDe5WhszGuhTQE2D3EOvzpR0lg==
X-Gm-Gg: AfdE7cmyuL598Kysfung0jmu5J8Vlt9SK/FbQkqKtGYlaMGyyAuwthYX5reiT42lLrQ
	/HcvC/cicsHkOIX5w9ZFMpNGsEjDfCNRO4+VmJkEoAJfRmK+1rz9xorN0H+IkaPNXiX14xV9upk
	CadT9gHmRkAMRgn2Z8cSB6XVz9X9RXk9zTXfi7bBV5rHSwrV9c4VKgINy7y7ioN3TKN/K6luuqW
	Gq1isZev1B1PJhbsCuvS3hAQkodWE5anzhCZ8K1VdyKnwKaiK9uzolExylpOCKCcdbE2AkERUSp
	IfqciztlbZAILoETcXBCotZ9vOVGuHVZsdD9szC0Oyni2wsVniAojVaylg8OjpdO9KEXfEud7z8
	4clQNTQ==
X-Received: by 2002:a17:907:7b82:b0:c0e:883e:93fd with SMTP id
 a640c23a62f3a-c16619189d8mr390316766b.48.1784101220517; Wed, 15 Jul 2026
 00:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081124.90962-1-mhun512@gmail.com> <edc9c916-1a9b-407d-b2e4-cd8709287a34@intel.com>
In-Reply-To: <edc9c916-1a9b-407d-b2e4-cd8709287a34@intel.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 15 Jul 2026 16:40:08 +0900
X-Gm-Features: AUfX_mwF8rw8M5B3ICI8wj67I6_sihRqUfRxt_fZ9SmAsrUyUR8MYWyVag-xsxQ
Message-ID: <CAGEsz8EyKpppgu57nsdtw73H5HSufgKh7GMMhZcQuaJkQa=WMA@mail.gmail.com>
Subject: Re: [PATCH] idpf: disable PCIe PTM on device removal
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Milena Olech <milena.olech@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:emil.s.tantilov@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:milena.olech@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D96AF75B8FC

Thanks, you're right. A successful pci_enable_ptm() is followed by
several operations that may fail, and those paths currently return
without disabling PTM.

I'll add pci_disable_ptm() to the common probe error unwind path and
send a v2.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:37, T=
antilov, Emil S <emil.s.tantilov@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On 7/14/2026 1:11 AM, Myeonghun Pak wrote:
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(pdev, NULL), which programs the PTM control bits and set=
s
> > pdev->ptm_enabled when the bus/controller supports it.  The teardown pa=
th
> > in idpf_remove() releases the workqueues, vports, mutexes and the adapt=
er
> > memory but never calls pci_disable_ptm(), so PTM is left enabled on the
> > device after the driver detaches.
> >
> > This leaves the PCI core's software PTM state and the device's PTM cont=
rol
> > bits set with no bound driver.  pcim_enable_device() only arranges for
> > pci_disable_device() on teardown and does not undo the PTM enable, so i=
t
> > is not a substitute here.
> >
> > Pair the enable with pci_disable_ptm(pdev) in idpf_remove(), matching t=
he
> > igc and mlx5 drivers which already disable PTM on their remove paths.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/=
ethernet/intel/idpf/idpf_main.c
> > index 0dd741dcfc..3d3471d3f7 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     pci_disable_ptm(pdev);
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >   }
>
> I think another call will also be needed in idpf_probe() in the error
> path, following pci_enable_ptm().
>
> Thanks,
> Emil

