Return-Path: <netdev+bounces-301925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tctcIKX/PGogvggAu9opvQ
	(envelope-from <netdev+bounces-301925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F146C4872
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=aG3teuix;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301925-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0170F301388C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FCC3CEBB1;
	Thu, 25 Jun 2026 10:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BF38655C
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:14:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382499; cv=pass; b=NFpLm/fMKNzVLUHfa7lQbR32UcV4AKNRY1HD67BxSIosBbnxFgrsscU9El+a8IaCKv8Eg4Zgum/LKtFtr0vxSoVMhUBXSxmSyIc6Qbq91vTyz7pR3K2GE6HaW7QR88R0jLL/lmzZQzSdfAJml2MTVeg6hnATDyfrp11IcwR42oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382499; c=relaxed/simple;
	bh=NxyLuypPpk6MhkS0AtR8937kwxS2DQg+2Qk8Htxk2U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdC1LOjYnrfU3SnWnUeMXABfe9iMTqjzsfGcLv89axL9CN0yEviLy6+aJiVAcwpNnfXnQMFbc8g3GMahxXH64yfyXcp943JG4i8uhxHdNkIE8502lrSXKhs5AVhABMg2lURaDGHeY8oW2WiFG5VeBmphZ+3QMAmwgKdLLjUplmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aG3teuix; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 686923F6ED
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782382488;
	bh=eTF4zUQ/sXytzxyjzk0NCCLZSwx0zHz2xiig6UQLvv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aG3teuixUsVnJCHqlGnqTbgkVH3gM+iRrbBdM9sxvU8z1vYeinDOQHZyfIjDhbOOr
	 UII2fRe0IIaWV43UjQo8cg5GkxyBC4Kwn5wh43tPIHvyzbJkhFgdPrDI4ZG1/gjjrM
	 CkHOMVgTESPwPA4lo2+7PPax0VzlhmW42d0xrgsnTyvCktB7/D3fjs13/4fMKkIuk1
	 swHHYvv+Gom+JMUFDe3QHUqcYNyhA3mSjO/Y8WpIukI/oKfESqfd9H+2SqR1JHjMlM
	 UeigujonsJTqxhFQRz22R1lkCXKlM6PIpapzdHD3ES2GQb1R+dbu/a32crx66QOIkp
	 wcMBBD1lhneHxD1bepprQ5pYgw9FcSM6psBXy+pK9iIOylr44JnU7LVrlhpwpTb18s
	 fghytxi3q5fvWRiV86Bo8pGpf31e+ZRYrcbGMjjzy3qf/p4xn3nDqGVvcWRf0O7/6r
	 W52yEGh8kKNr450FJz1zQgP7NispL7akJ1ihFBWRuRv7Vpof1LZvPv+UHjQFB4QxK+
	 qBbldpba7k7Cr3lKwGq8MsQZcR+2wkbbJ3BlBMJwMSqArcF/9IQbwjekRwOSpM4FEb
	 dYVKmfQ9tincdrcqhUkerp4DYBPyfo7/4HuAGxZKQosHrVY8/tTwDnpZuHWny/BPIz
	 vh0mDNZpE9vj+csQawCOaav8=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bf481a6e4e6so181972366b.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782382488; cv=none;
        d=google.com; s=arc-20260327;
        b=oZoUciobda6aXfQdyesFv59lXNfiZozOXLXfNSzlvXUqxzJgLYOtxmrXRhO39v0+uW
         7rQkTV3Yuwc60aUG+GD3GnKLNuUUszFs68ZGa4RoCfIwFpiHonV/EgU2otNbOzi3HY2x
         0VGFM7f258ouSG7hHOxqqZ25gPrfTyrzEsO9v6j9YKvpUDvw6fK4s7AuHegJ1zINSWyO
         3/4olS2CPEqAKyjoVCRHBDhtUdkafB3rHqAk3vlYYY3cxLLmvf3ercP5o9PSlGx5Gll3
         OBzKqeo5lGdgo43qoo5OFNt5RJy5EQRz6RDsd39HgtMYdr8BHq3apGfeFJyrO2UIC/G4
         M7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=eTF4zUQ/sXytzxyjzk0NCCLZSwx0zHz2xiig6UQLvv4=;
        fh=9L4ifBOqUcWqw+rBtJXM3IyXAlq2BBx0dU7N4Bu4u78=;
        b=sV1fYWAtxGLUsCXULEyiLnq41iDKZAa1XWKUZznTPdCHoZVGJiF+42DqLgEztmTc2/
         zYpB8oXtgxf2KUWKl5F8KmlknYSPPiqLcKvNGBRj/N2H8L6TH9uOg/dHBT9jhEnYKQ+Z
         hTvNyxGhAmc9A7zg6P+h8p62EFr2IRfDWgg0GQZDPJHP1IFhZEXmpctjVW9uBonzq2Cg
         GTrYaXsnmt8dkE3KAMYXEdc0jusyXI/9Sw+jPdXARiVqS0S1Bu05NRulTi78uc6TxqL3
         pYNC8lVKmOlsf2Wk4sk8CyI+Fk0NCYq2AJiucSK1kltjtsPVQPJvYnASO0jUhEj3MXmo
         JI/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382488; x=1782987288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTF4zUQ/sXytzxyjzk0NCCLZSwx0zHz2xiig6UQLvv4=;
        b=m1nqh6fOSYCFlNVnwlgfwK1VLuny03jXqCrdqFtIbAEhjk8o2KmJFGznc4if2t11Vo
         4qANyFDHiwl47WB/aOK1OXZAj1Dc6CtgmdZqawVcHWzkXcD3NHRKaC0Jmp5ceAP+b8I0
         H+4rKRstV65eM09upZX+U5dJSMy+LZaz6DKtc5Fh60kJfzxtAZHpIjn5xeQFIon1ngrF
         Rm39zI4Dt2QN+vM0a384otJorHMQs0w5mM8lAKNipQDcEFsu+TUQGVv2ArNhI73WNcBr
         7BjIKeJbpoyUqB/UjYCAm5KVvnvNlwaA8E+tYPWk6R95vL5t8tO24wvdE13Kb5Ix8CDb
         Wegg==
X-Forwarded-Encrypted: i=1; AHgh+RqIyBc7vjkR5fcYRjzKJS3EAgyjSlL7dmLAbBPD4LCPHc3MGaamcPa1X4WLwHaVCeJ0ouX9rKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpK35sfucrG6SDj/1IWHqaMtx4riQEQU6M5ul2TquHo7EkBH3
	PaX13KhcNZNOvreIIepk5RarSsm/Cho6x2diBVmCBwxNWJTW3cKE4FONdTvd8GLDS4SOI59scvv
	Mkk/tPXiEjywKIEqP9IzqszlG+oj1GuDHV8oQc5BOC/+QrM58VpmByOCU2OJkbjBwrWNFSiqwSg
	L5YdaKNL8M9OG90R0wCtOWENuY6kQATeUMVYyJJmy0vzQDvuAJ
X-Gm-Gg: AfdE7cnPZo4qIRr/2EJ9Pg40xiKo/FIPpkr4EWbI+La1j82W2DySky8k7DFJYEz1p5H
	kW6KqQhvjvYL07ku8RiPBxudVGRnVKeRMFa1hfXeQLeP++SCJFxZhCtTk054plHqJ4ocxbaQAzk
	oG92A6s4JWxtTkEu3qTNn+9Rx81DGtSqA96AF8ZsNjfxI1eXqldVdjr9Blj5cJ3iYvZA==
X-Received: by 2002:a17:906:9f87:b0:bee:c13f:7ec0 with SMTP id a640c23a62f3a-c1205d9863bmr132176766b.8.1782382487735;
        Thu, 25 Jun 2026 03:14:47 -0700 (PDT)
X-Received: by 2002:a17:906:9f87:b0:bee:c13f:7ec0 with SMTP id
 a640c23a62f3a-c1205d9863bmr132173466b.8.1782382487118; Thu, 25 Jun 2026
 03:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617120753.1785565-1-robert.malz@canonical.com>
 <20260618152003.909400-1-horms@kernel.org> <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
 <5658849b-0425-4132-ba32-5801e2907c60@intel.com>
In-Reply-To: <5658849b-0425-4132-ba32-5801e2907c60@intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Thu, 25 Jun 2026 12:14:35 +0200
X-Gm-Features: AVVi8Cf26lyKrmpyACKceEiVOkf60PnI2cxp-Ngd284thAHkNtOJlwpsFvJ_U1Y
Message-ID: <CADcc-bwd2CcWJ1AFDm1GR1HBzo2OOh=Xr3moNS+-RVuai6yVBA@mail.gmail.com>
Subject: Re: [PATCH iwl v3] ice: retry reading NVM if admin queue returns EBUSY
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301925-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:grzegorz.nitka@intel.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:from_mime,mail.gmail.com:mid,intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4F146C4872

Hey Przemek,
Thanks a lot for the feedback.
I was sure that we use ICE_NVM_TIMEOUT (180s) as a timeout every time
(ice_acquire_nvm) but your proposal made me rethink it a little.
First of all, the datasheet for E810 specifies the timeout as: "As an
input, the software might specify timeout longer than the default
taken for this resource, and up to one minute."
180s is greater than one minute so I took a look into AQC logs:
[  110.698471] ice 0000:05:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
datalen 0x0000, retval 0x0000
[  110.698474] ice 0000:05:00.0:        cookie (h,l) 0x00000000 0x00000000
[  110.698477] ice 0000:05:00.0:        param (0,1)  0x00010001 0x0002BF20
[  110.698480] ice 0000:05:00.0:        addr (h,l)   0x00000000 0x00000000
[  110.698645] ice 0000:05:00.0: ATQ: desc and buffer writeback:
[  110.698648] ice 0000:05:00.0: CQ CMD: opcode 0x0008, flags 0x2003,
datalen 0x0000, retval 0x0000
[  110.698651] ice 0000:05:00.0:        cookie (h,l) 0x00000000 0x00000000
[  110.698654] ice 0000:05:00.0:        param (0,1)  0x00010001 0x00000BB8
[  110.698657] ice 0000:05:00.0:        addr (h,l)   0x00000000 0x00000000
Based on the above, the driver requested a 0x0002BF20 timeout (180 000
ms) but the FW returned only 0x00000BB8 (3s).
I'm assuming this is expected behavior since the maximum timeout for
NVM read should be 60,000 ms.

If changing the timeout requested by the driver to 60s for read ops is
handled correctly by the FW and the FW respects that lock, the retry
patch submitted in this email thread might not be required at all.
Let me quickly prepare a new patch and test it. I'll update this
thread once I have a results.

Regards,
Robert


On Thu, Jun 25, 2026 at 9:51=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> >> This is an AI-generated review of your patch. The human sending this
>
>
> >> [Severity: Low]
> >> Does this check allow an extra retry execution? Since retry_cnt starts=
 at 0,
> >> using a strictly greater-than check allows the loop to retry 4 times
> >> (5 total executions) instead of the 3 executions intended by
> >> ICE_SQ_SEND_MAX_EXECUTE.
> >>
> >>> +                             break;
> >>> +                     ice_debug(hw, ICE_DBG_NVM,
> >>> +                               "NVM read EBUSY error, retry %d\n",
> >>> +                               retry_cnt + 1);
> >>> +                     last_cmd =3D false;
> >>> +                     ice_release_nvm(hw);
> >>> +                     msleep(ICE_SQ_SEND_DELAY_TIME_MS);
> >>
> > The review is correct that this allows one extra execution. However, I
> > intentionally kept this verbatim from the OOT driver (1.15.4) to
>
> This OOT change was made entirely by Grzegorz, for E825C. Would be great
> to acknowledge his authorship (+ SoB ofc, below).
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> What was the platform that you have encountered the bug on?
>
> > retain the significant test exposure it has there. The absolute worst
> > case is one harmless extra retry before giving up. If you strongly
> > prefer strict adherence to ICE_SQ_SEND_MAX_EXECUTE, I can update the
> > condition in a v4.
>
> Please update (to have one attempt less).
>
> >
> >> [Severity: High]
> >> Does dropping the NVM lock here violate the caller's assumption of mut=
ual
> >> exclusion?
> >>
> >> Callers of ice_read_flat_nvm() typically acquire the NVM lock beforeha=
nd to
> >> ensure an atomic read of multiple sectors without interleaved writes. =
By
> >> explicitly dropping the lock during the msleep() window, another threa=
d, VF,
> >> or PF could acquire the NVM lock and modify the NVM before the read re=
sumes,
> >> potentially resulting in reading torn or inconsistent NVM data.
> >>
> >>> +                     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> >>> +                     if (status)
> >>> +                             break;
> >>
> >
> > I don't think this is an issue. The NVM resource (req_res 0x0008) is
> > an ownership lease, not a content snapshot. The FW grants it with a
> > hold timeout (see the timeout field handling in ice_aq_req_res). It
> > never guaranteed a point-in-time view of the flash.
> > Very similar behavior already exists in ice_devlink_nvm_snapshot(),
> > which reads the NVM in chunks via ice_read_flat_nvm() and deliberately
> > acquires/releases the lock between chunks (with a comment explaining
> > the FW reclaim).
> > Additionally, the lock is only dropped on the failure path, where
> > neither bytes_read nor offset have been advanced. The driver simply
> > re-reads the failed chunk after re-acquiring. So no data that is
> > returned to the caller is committed across the drop window.
> > Overall the lock drop does not weaken any guarantee callers actually
> > have. If we wanted to introduce a true snapshot guarantee, that would
> > probably require different approach and separate patch.
> >
> >
> >> [Severity: High]
> >> Can this lead to an unbalanced NVM resource lock release and potential=
 data
> >> corruption?
> >>
> >> If ice_acquire_nvm() fails here, the loop breaks and returns an error =
with the
> >> lock currently unheld. However, callers like ice_read_flash_module() a=
re
> >> unaware of this internal lock state change and will unconditionally ca=
ll
> >> ice_release_nvm() upon failure:
> >>
> >> drivers/net/ethernet/intel/ice/ice_nvm.c:ice_read_flash_module() {
> >>          status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> >>          if (status)
> >>                  return status;
> >>
> >>          status =3D ice_read_flat_nvm(hw, start + offset, &length, dat=
a, false);
> >>
> >>          ice_release_nvm(hw);
> >>      ...
> >>
> >> Because firmware tracks resource locks per-PF rather than per-OS-threa=
d, this
> >> errant second release could forcefully strip the lock from another thr=
ead on
> >> the same PF that successfully acquired it, exposing the NVM to concurr=
ent
> >> modification.
> >>
> >
> > Agreed, this might be a real bug, and the one of the three I think is
> > worth investigating.
> > If ice_acquire_nvm() fails after the drop, ice_read_flat_nvm() returns
> > with the lock unheld while callers unconditionally call
> > ice_release_nvm(), so a stray release is issued.
> >
> > On probability, though, the window is very small. Reaching it requires
> > sustained EBUSY across the retry budget plus a failed re-acquire
> > (which itself polls up to ICE_NVM_TIMEOUT), and concurrently another
> > requester taking the lock. Most reads happen during init (ice_probe,
> > and reset/rebuild via ice_init_nvm), and NVM writes only happen on an
> > already initialized driver. The devlink/ethtool nvm_read paths are
> > also exposed, but hitting this race would require precise timing
> > against a concurrent NVM owner on the device.
> >
> > I'd prefer to keep the scope of this patch limited to the EBUSY retry
> > path and not take on the unbalanced-release fix here. A proper fix
> > should change the lock-ownership contract of ice_read_flat_nvm() (on
> > error, the lock must be released by ice_read_flat_nvm(), callers
> > release only on success) and update all callers. Code change sould be
> > simple for all callers but ice_discover_flash_size(), it intentionally
> > holds one lease across a read loop and would need to re-acquire after
> > each expected boundary failure.
> >
> > Given how small the original window is, I'd rather not trade tested
> > OOT behavior for the risk of a complex unbalanced NVM lock fix. I
> > actually have a patch mostly ready that fixes the lock-ownership
> > contract, but I really don't like it. It changes the design of
> > ice_read_flat_nvm(), making it less intuitive for callers. More
> > importantly, I just don't have the resources or test coverage right
> > now to properly verify such change.
> >
> > However, I can modify the failure path for ice_acquire_nvm inside
> > ice_read_flat_nvm. Instead of bailing out immediately, we can just
> > retry it within the existing retry budget. In this case, the
> > probability of leaving ice_read_flat_nvm without holding the lock is
> > reduced even further without needing a refactor.
> >
> > Please let me know what you think about my thought process on this.
>
> I think that both AI-reported issues against the lock are valid
> concerns.
>
> I think that sleep was the actual fix, and re-locking were merely
> a necessity due to their expiration (as you said).
>
> A proper fix would be to just increase lock-timeout to accommodate all
> attempts (and still do the retries&sleep, but without unlocking).
>
>
> >
> >
> >
> >>> +                     retry_cnt++;
> >>> +             } else {
> >>> +                     bytes_read +=3D read_size;
> >>> +                     offset +=3D read_size;
> >>> +                     retry_cnt =3D 0;
> >>> +             }
> >>>        } while (!last_cmd);
> >>>
> >>>        *length =3D bytes_read;
> >
> > Thanks,
> > Robert
>

