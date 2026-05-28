Return-Path: <netdev+bounces-292761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNOpAdZrGGrcjggAu9opvQ
	(envelope-from <netdev+bounces-292761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C153D5F4EBE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 824F33168E07
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818B347C6;
	Thu, 28 May 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI0E5iR+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E896230BD9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984656; cv=pass; b=TnciRpNovYB0044VAEk6MB72UGH9jQ3+vd23RHjEZoiXIOYfALlmzzKyZGF6MHFnyoWvk1hLZU/Wxl77dVuYFWSqZHkNQMITZPhYaLtaQXi77/0ZXpCf2jeK9pyRUILCO0rUUXS1zsXCSnQpqzA3BKpRQbXe2Qr6mk+Qc+m3490=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984656; c=relaxed/simple;
	bh=73qZ2fA//WJnPca1iArJvVgVsdhtg7eELc00kVkm0cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzQryEvcXQE8UGx1pgO1DXPSvP5Gz0h4HGR/0iwOJMZPCvZCnQ2pSktvx9IB41QBm4wqVD4akZKxyGZGygRM1wzwzWm2/HL1T4n5mDoWItPB19WiofBgycw+KBi0eA/LqLkvVkI+bmgYBBGXafVtjm20JDDbgjXRtmEA8PiG0YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI0E5iR+; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c58e6eb2c8so131693537b3.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779984654; cv=none;
        d=google.com; s=arc-20240605;
        b=NSPZyyjoazhskbn1TE/fm4XzWoQ7e5BGA2Y2Rvy4VU/u8Rk/WoRYV177QZQ86v+SI8
         pWDnZIG5+Ar81HHGBIHBToXmmSgNCFeN1crOzpifP9uKs+hHgqU+9kCkUGuQVTnEvoAS
         OHehsLKAx5z6VVRYQ5ZrXpxg21FG9aYaqDnMSB7LNlBkIvtIISs9VSL54ae8Jz1apmlr
         T3yVj9umAaUOnRjWlpYQ72Bu1ecd6Q+FrEAkCmoIoY0mLTbsFCxjU0CDaKi2+YKo4PE7
         pqt6df/fl4LVnGNrdynya7lYICUUo1FtKD67vf3h3VBG3KSJByIkFjvBNDS/6MVlm6EA
         YAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lODgCiQuy5TCo774av5NJKOq60qieSg5D09eEllVGVQ=;
        fh=fCgyUtUfRqHlaRDtPPC38qiExacJ7T0+YvgBIInupOg=;
        b=jzXQinPraBPzauyQkVxHQLciBuSrTUh1sAQilMk9MSEBJ6ph7JVTKzTQws/YyA5GMk
         9e/6Ot4ZLMZOomx7aH47mm6JcM/xa11XgNAi0MZJGih1xR+eNpHjHcxSqxYRpMYR2CFQ
         5uRFbczPjNTwQc8Eqrn0hDY6pSV8ZuqeXw06tacCglNCvVTMFMhCv2ZElC3QdY4JshQY
         pVqamGW4LTmpbJAWh+KtWk6tiZTYQ5MlFGsS4nnzM4z3kAt7LlIY8S0IyCU1pVeHyglS
         78CV3B1nakoSKUMeRbpztpeTIeqiAt1jSImZpgcMclzccfX6OStFwmY4A6lmJqvkPbc2
         XFdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779984654; x=1780589454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lODgCiQuy5TCo774av5NJKOq60qieSg5D09eEllVGVQ=;
        b=iI0E5iR+Is4o9b3YwFVu8LMhZcF8+On7sIYv5GV3VFWXjW1BVs2v88uQyR03aP29oo
         RsTlr8C4z1fZ3BxVxFrjq/xmkVBQxrbwpZz8Tzns65Qyqx7sewShV9cTql0WU+/Naqtl
         6GQWcZuDKYNbbWV9B8xvt24oZuxLKRBUJrlSUPu02FEClekrR7U28H4LyES/LMfQ1CMw
         7J0HveX4HITeQYfTCWeZn3FRmelldtvpjKkc3zNw/K+eZfyet/lIKvisj91Sg5Of+Tfd
         VA9z2zOJ+cdlxTVTn+5CZ1mFOjyme7V1ojGJvYwiCVa15vXO748b6oEgEDL6f1uvCOLC
         W3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984654; x=1780589454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lODgCiQuy5TCo774av5NJKOq60qieSg5D09eEllVGVQ=;
        b=kC9CeCgD1BXNlkON50SiV/vFj6YLAvxQEjVcTIGlS/8w8X9eOjBT+7fRNgsnIYNZZv
         +99TjptHSRvAmxMFx7T0V/ztM1ClBF1g/+cgwQa42TtNwq1NHGFviTsVgObOPK4SNSLh
         wDmpFhHqUd0kpFpRsuF78DUBnDncKbTVtO/VA97X6gsxOvyUmx/9QrMDmLMoqAL6S3kl
         heCS2KxuPOLQUWRQBaQAQLgf+dLwbHzJxhntfuuyVQerNcomepla2J7byTCe1k8I9sal
         SW5upk7gvK/anJjfyPcYhQE0irk2R3RwNsONx+pcBwdZgcjk4gtlfGYEE7wW7V4geFZD
         PMOA==
X-Forwarded-Encrypted: i=1; AFNElJ/VqNW9AU4rCCtRACs5gucLl5P8OwlQBF39ux9ihUXbCrMTWBxh/yFUqIkqjEB+tU3oF5dF3Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+t2b3LnMO2PTNO70tRTJCY+a8wgtnbYbZmdPMFAtSI18FdV6
	EWwKWXxfOHxemN1hB5wMIb+iotBWkHKvGOCShnkbzNXL2FKbplVUfI2OypG6IJ3l8q0QhdJQx16
	1tCZp8Mhodn3ZR+cLEwx6arhQLAEAmvg=
X-Gm-Gg: Acq92OEDAVpApHup5eSFKXBTDKOWZo5agtycRmHy+z07OCi70jk14WT7OBVfq+gGY2C
	MkhlIXmo2YpEr8DuMB3iBt1juMw775K+8SzMc0JZ40j7SN6kq/oWrB8gHgs2Y1KKZ+i9hecOOs4
	WtoYerOMg3gFkYS3EsazsTQ+gpsQglDVdnsGz4VTErXIDuDG32a8ovZp6jI26dhwys3aDoVxKLO
	d8SVniMcRHw7orvxysI3gn6serI4+F8YyKCQzZmiInPmVX8ciUi2DiXxoKVV92levhw38Xyw244
	Gm8AqnqcrrL4hZRX3YMmgg6mrcw7+88QReXVaj7lLkQpanFqohwQG3my8IpCq9+5iabT1IG+EKD
	X8Xaw
X-Received: by 2002:a05:690c:6f06:b0:7bd:5c9e:2397 with SMTP id
 00721157ae682-7d336caefc9mr298941017b3.30.1779984654364; Thu, 28 May 2026
 09:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528131839.462344-1-luiz.dentz@gmail.com> <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
In-Reply-To: <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 12:10:43 -0400
X-Gm-Features: AVHnY4IB-v7dq0G3myesX_FTcdDQG3vL_MATT20rWCopGe_ci2Rgrgz3prMu-9g
Message-ID: <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292761-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C153D5F4EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On Thu, May 28, 2026 at 11:52=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/28/26 3:18 PM, Luiz Augusto von Dentz wrote:
> > The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48=
e022:
> >
> >   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()=
 (2026-05-20 16:35:47 -0400)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2026-05-28
> >
> > for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72=
:
> >
> >   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2=
026-05-28 08:52:21 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
> >
> >  - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
> >  - hci_conn: Fix memory leak in hci_le_big_terminate()
> >  - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
> >  - hci_sync: Reset device counters in hci_dev_close_sync()
> >  - hci_sync: fix UAF in hci_le_create_cis_sync
> >  - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
> >  - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
> >  - L2CAP: use chan timer to close channels in cleanup_listen()
> >  - L2CAP: clear chan->ident on ECRED reconfiguration success
> >  - ISO: fix UAF in iso_recv_frame
> >  - ISO: serialize iso_sock_clear_timer with socket lock
> >  - HIDP: fix missing length checks in hidp_input_report()
> >  - 6lowpan: check skb_clone() return value in send_mcast_pkt()
> >  - btusb: Allow firmware re-download when version matches
> >  - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
>
> I'm sorry, it did not fit today's net PR; I started cooking it quite a
> bit earlier than this one, and I looked back at the ML only after
> completion.

Well I guess it will need to be merged for the next PR. That said, I
wonder if I need to submit it one day earlier since there is a risk it
doesn't get merged immediately, causing us to miss a week of the RC
cycle. Maybe due to high influx of AI/Security patches we will need to
submit it twice a week or something.

--=20
Luiz Augusto von Dentz

