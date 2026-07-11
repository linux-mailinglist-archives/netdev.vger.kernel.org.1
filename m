Return-Path: <netdev+bounces-306747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8P60OWbTUWptJQMAu9opvQ
	(envelope-from <netdev+bounces-306747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 07:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E85740600
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 07:23:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uMLMV+aT;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306747-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306747-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F5E300F0D9
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 05:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D32EEE89;
	Sat, 11 Jul 2026 05:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FB1D95A3
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:23:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747417; cv=pass; b=rAYVfyevkNg6rP1B8UV57/kZXCNAijSJqRanfkmzYmGVtdfsQ3qr0roQKOsP1ILCgDuNU2pWgNJpZvjPcsbil+hhoKhnfjRE6j+6chEH+QjxVaYC1kv6xpbZZq+tLSHYy+PSwk+Tb+IuOkS8o0sPSIXFO1JhoR6RTArIikPfD+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747417; c=relaxed/simple;
	bh=Vbir7G5U1uaNCQUvONVRUrXkoAxD/zZpwy+1cUqwLTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf71/8uKcUxBlRL/Ci76Ck7VX53zHS+MjuYaUNX5G1b3pB9cQ3YKclTCYvlcMLk810au6+rECSUbbDTMQ3j8NETTyP9zEhE6CF5J90Q3aqljiJcB2SKYUXDDi20EPvJMXWg14h4cq8bdnJNp2EBgv3Zp1ziX4QXB/v5Oqkb1Va0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMLMV+aT; arc=pass smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so5941a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 22:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783747413; cv=none;
        d=google.com; s=arc-20260327;
        b=AiSeaUBFuzLpETkic2DnN71f1a9RC1z3ELIA/ukYol8h2WLO2S6P2lMNxkoW9vwwu+
         Fbbi55coPkgnPQGLPZWR9vtDR2gigStcVLjdbqO01g0yr4aGnGqdMtl6b24FFMR4uqaj
         2hlW+6aw7w3exXGbGhwz7jGwbOz8SG2+Bhyy5r91rhHbLsqMqZzy6HUH/Zc0QNd/Ub3G
         Z0M8ZDTo6PgIergxZrRZOwqSZKaOVHz5xR4CwIJBa7BTFczNaN8/hEDuJcGLmy7l3Hks
         q2cJ7w1J4LN+A7KjXZkxQavMbo/AJRr+4tulQ4Mplbve0P9eo1JdPmhQjwS5WRTGBP+i
         isBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        fh=KbgZtZk1QQ0TJDGCFtZMzGtSTzSY/x4p769FudZRqjU=;
        b=NZ/al8F11TU+syjwzAXE1UqNMFoHxhrXj2b9rtriPPh4XUlmoU1MzSBIiECYsWgdee
         AqjHnnkPGaX+cTQ65L2x4y5oJHBkd8ci79TZ8vR7QCY0KboCpG0E4zswW90oZei7el92
         w+d3EKX1EiX8AtFWa9Z1tlggsqWDPF5hgRmqQR4NlPhpWVK+24zqItFH8QYr7+UfpPr9
         0LqLF0UwinoUeGozxGfW918SuQR0324CIA5+eCtRfJJziaC7NTukeaORhk6PMIJXCulh
         6fhwcFGa5eSALpOCjF47rVKKtGgT/BNv/s+JjzHUzdhTsPCaqZtPcf+hgSTyiG8JxvuH
         XcEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783747413; x=1784352213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=uMLMV+aTWkeWUHipxJyPqLC2MpcMozM30UZCy1jb/ql60bX0tr/2iJAjWKGcYTeWuc
         rBvOBOQF04AjwvOFVSbWvnC8Z5C6zl4df/hbZ1Cyjtczz8dweZCty07TJrb9BqClY1WP
         vnrwQmeH73mLEYg3cnRyrsPLJwnkYIev6mVnyj8de83Ze80EKQThAVSuMYf8012osHe0
         gW8trad3BobyZ4nw3geWCwmmkVGBYrOzKZpywbyj+M/iQ7uSVR2Pajfafm/L+cYkEAts
         vZgYDJbIstw8naA+B1eR7wKyz2hAFz9CshKi2s2lP9+uIXNSqxxy0F6ebq9zlDvZGW0A
         sA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783747413; x=1784352213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=FMpofQHN+wALEgxFnPx79f88HFZgECs/poIYGcHNZBQzLRhRia6U9+HLOyYBKW9BBg
         RYIct0OeAeGrFhApGrZwj6ujL/aZyaQwYvqTHFKmawgPc3on39ZqV7Ks9AmqRieQvUJE
         8bDXObYWN0Pc4Z1x2rHpVbPK3wsWFKUsD7tmUjmk4FzRLrGHKFflhMReNw8lUOSBso9P
         RdDv3z3gvukvIY4Osbdb55YILsF++T+lCIl0mapj7N6eJFM71FRw9EdaBsQa8+E0YT5A
         muSNikgBgzEjmG5ZPPnEx5TvWwyuZmJu1aqvC5+FutWJr3Ubl+xBQaqIJOZcOwzb87nr
         bMXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpM8qhRwz7h/enq+K3aDhjoFN2zBcgEEjfIn7rfenvrTQeB4zwhbV+Uw5rj3VEEXwtI0yMUStE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFL5qmSpXq68xg4k0dyIxnsfpE01DQB8jpc8tkKlXDtg8Gadh
	s2KA3x3K3IsTFEXsK7g1iePZMh1PUfL0wLp+b1RAiadlyVnP7DlBzL6UdVEiZ7V9h1hDBpA4qHa
	hBOvI92c3Vo2z6wfdvFZz9XhgDLPjJzsU6J9yFKap
X-Gm-Gg: AfdE7cmh9S5XVO8HaDYTmKKYkMPsztSlIARBD598hq3+Tt/RV6kzXMhqzf/naYfY8Vq
	wbwalKFlj2u5M8QVpfoE+MJzPI7aES827yGoYl1JYyXjuJ6/elAE6oya3Jp0EW3NzbTDA7By/Qc
	jyOlnDM2Kypb0ALLknIvPDOLMnIJAQU1HlVnVqhz5zspERVYr5o0SIsMVmjfx10OYnNONyPVtZ5
	H3OdDJVzsi9u8k8zbYsc5+ozSadXFNRVXGhXJ44zM1dHDx43z2Jj4CQZbZqeGPkL45DKt/8zE0j
	7/FjcF/TNJahvSNeDJDuwJcclAXTrBk+GFirxJWB8QcYscP+g+1d5SN9kWiZC/g=
X-Received: by 2002:a05:6402:564b:b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69c5f806bbdmr32702a12.6.1783747412689; Fri, 10 Jul 2026
 22:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101635.103005-1-fanwu01@zju.edu.cn> <20260710002451.500112-1-eddiephillips@google.com>
 <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
In-Reply-To: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 10 Jul 2026 22:23:20 -0700
X-Gm-Features: AUfX_mwj7DPyIzPgMc2aLdczV-n7IZVIQgU2ji0mGrRtnih3_s-rWd9eqlLTuGM
Message-ID: <CAPBb8HnN2Q2_aMRQ5Tv=pbi6Mz=Qe3CJkAucUx858_+_AW4efA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>, Wright Feng <wright.feng@infineon.com>, 
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:fanwu01@zju.edu.cn,m:aspriel@gmail.com,m:kvalo@kernel.org,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eddiephillips@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[zju.edu.cn,gmail.com,kernel.org,broadcom.com,infineon.com,davemloft.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddiephillips@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1E85740600

On Fri, Jul 10, 2026 at 12:18=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/07/2026 02:23, Eddie Phillips wrote:
> > On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> >
> >> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> >> drvr->bus_reset, whose callback recovers drvr through container_of()
> >> and dereferences it.  The teardown paths free drvr (brcmf_free ->
> >> wiphy_free) without draining the work, so a bus_reset callback pending
> >> or running during removal can outlive drvr.
> >>
>
> [...]
>
> >>
> >> This issue was found by an in-house static analysis tool.
> >>
> >> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> >> Assisted-by: Codex:gpt-5.5
> >> ---
> >>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
> >>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++=
--
> >>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
> >>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >>   7 files changed, 66 insertions(+), 2 deletions(-)
>
> [...]
>
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> index fed9cd5f2..b934feb9b 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *=
s, void *data)
> >>      return 0;
> >>   }
> >>
> >> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed)=
 against the
> >> + * teardown drain: the remove path takes bus_reset_lock, sets ->remov=
ing and cancels
> >> + * the work under it, so a racing armer either schedules before the c=
ancel (and is
> >> + * drained) or observes ->removing and desists.
> >> + */
> >> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->remo=
ving)
> >> +            schedule_work(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > Is this safe in a softIRQ context?
> > mutex_lock() sleeps until it can get the lock.
>
> What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and
> SDIO (worker).

Yes, you're right. Since it's thread/worker context, sleeping is fine here.

> >> +
> >> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    bus_if->removing =3D true;
> >> +    if (bus_if->drvr)
> >> +            cancel_work_sync(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> > takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> > path is already running, it can invoke the worker thread. Is there
> > potential that both try to reset?
>
> What is "both" here?

It may be possible that the worker thread is running and then the device is
unplugged, causing a deadlock.

Another possibility here would be to just lock the state change, but both
implementations should are fine.

Best, Eddie

> Regards,
> Arend

