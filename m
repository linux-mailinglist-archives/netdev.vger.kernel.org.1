Return-Path: <netdev+bounces-276859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBE1L5ZR12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:13:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE833C6DDF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F156A300F96D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FD37187B;
	Thu,  9 Apr 2026 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoTC1w4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87B308F32
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718803; cv=pass; b=O/Vofq8Nf13dfqA661Cr9ocK7dcu+T63OmFAvMjhAEDSn7HmtW6d0maQce28HhkGyDUPnSJsUG0haXyK4gUPsWk4pWFv3G15BttC34JIRlUQMt/I0HMJi0OXQwio7vJyUg/P94C5H1Jec6q4L5w3WzwLFZnXhGFjyq1GOPIQrwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718803; c=relaxed/simple;
	bh=9DFaHZMYaCMqRR6Rx4RrfAGPj2L+2hco6S/i/9VyJtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuIyZXJzjhaeoczbrIbo4O2jw92zKoi5O/mx5xipqooxLWtb4Mu797ZduVnErkJWWObgxKNI4zKfM4OAmmxu8vlnJgEli5MARn1y9U7kIcHf/orRMDxLvt1yxTi0E6g6pmmG/9he8sE8xBPzsPAdYST+kMkjtXFpzEskxXBJiNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoTC1w4P; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b392f1846so9243841cf.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775718801; cv=none;
        d=google.com; s=arc-20240605;
        b=jOaUaTE/8DZoGbnRu8/0DxgVhhpkFfEnyAISn5H7ufE5CwrgQ+BZ/zEsr1LSVaEJmd
         Xg/iF2zpqB6qCAFF6yl1/GFskDUhTBVnaaqWUuon5cU7PicyFFD36njTR4xOb9YZRFtk
         +dmdIR+GxTGhAGg0la/qn+vzAMNz+e+bdW+lzzMZ6f+2xror7K4Kex4tRrXof5zIpfH+
         n0VrXzW86jUFCsytd7ge11UiSeAeFUpRCkDhIa/DcmMsXFNHMSTqNTVbx10sy2VOfSGM
         Uxlao0KZTsIEtUUGjQF6FQrTeqX5PHyf8drblbNI3//YacLpUc4xYZ41NC5N/AoGTPlp
         BAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N4t9qEuOwjjeNBEsJhxscNy9pF7gCA9F8HMy/E0F534=;
        fh=f4E7HkNM2fQGXBmVy46i+QLVt0GmkH+V13fhpkTRjMA=;
        b=PyVZqClm7Tff5Wit2Fvsh3cRMtaCscyXM0ihtIBE7eJ7nWkYXxcL5ZcrkSaRbBCjgj
         IEs2kW+fqlSDNih07HRIg4SRFp7uhdbktUg0V1jJo3Y0t3pGuahvAmPKds9WL3/U2waC
         /UrBLTGs0BtvLrcpx5hqUN4np0lDJDN5gFAqixJSPrZxh0QiuCEF6YAgNQjj/0nf27nx
         1ztW2askctESxnfrJ0Nj2XDpz/xOlOmM5rdmh5+4cLy7EaXlm2SJHSVbCdYGiYJ0Cgyl
         3pfvAM2JqJakWcn2BPcZzdfRvPwiBUvQXo+ZjeRU9AjYkQOAT++DWTmTUFYMN9YpjRv5
         SdBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775718801; x=1776323601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4t9qEuOwjjeNBEsJhxscNy9pF7gCA9F8HMy/E0F534=;
        b=SoTC1w4P4q/Z4E8T3s6sbx5wp8/sLsFladCaCgiSEmtmtS3d66ZdD9FwRIU5p3MGMl
         RuS08dfJkOBzx2F3w/BWvy4gqsk9iTS0qhS0GNCqCvruykyD9sQqY/LbJUG0ke9BCt/p
         leRIeTqIda4TdGvjMv/jr4szSLT9san/iPyVv15/kUojPl345dcRnB9wmqlo4+NgZRbK
         wHO63UISkyz+/ei83PrY7Ja3qh1q+ZhU/C4Zr7P7A5heJKk8VMNAeL9F7SVU886FRVV5
         XJeDCT7mBPp5JfGj4ejsCVzPkzUazTHJy1qX/Bbau+yDskjrTChvSYi5V9m2zLdS/EUK
         K3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718801; x=1776323601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4t9qEuOwjjeNBEsJhxscNy9pF7gCA9F8HMy/E0F534=;
        b=S17QCL2YQNrV3Kc6YDz3PZ/q62N0ebP0xJklAXLSi090BHE7p8KSOqGAWoqkiqee4Y
         zpaJkFneMcN8I1ZoAkpMH2mpsl1ljhPZg4DkpaarZyksN3J9ABo19fU3QgFvDVLcBo7V
         RWNg5+4sPULP1H/G0V2T1tub1KhtjO2bPXcC0zBGWl/RgJmfoJKmtZ/1FLk+zgMH7swx
         wjpVWI4c8Gyg1FnOwdjTIu8oSz1Acnq28xo/nFMX9WAqwB3DfMrN8oWR69hwXt/3epqY
         I1+MFRRJMDuzkRhj8KKlS15GVqna8jb1MfmFSIeiOV6caSO/mt16ItrE2eS3GcvP5MMg
         sRDA==
X-Gm-Message-State: AOJu0YyehCae69nWaDNqm90PfWaq5WluhXwbO0uMfKB94+UVbCmHG0m2
	GdJr7hJ6as3mcgLhEm4AzOovqVU1eMmAryz9aDEEN0ljo29IFs/wwt9BRecOhAa34bOZwKDkT1h
	1nrGGt4KbrRjExeeUFWbN98mmRlhNkC6iiNnixrXkhX7Ydc62mn4O7Iyd
X-Gm-Gg: AeBDiesIlre0vbITn//l4UOs8w+NHU01puu2bV+8Z2acqgY/TWINIIgqRh9CD1o9ewL
	eGtLBnq776wWkcz8Kb7eudLU/wrkdPa7QhzkM0ACUWJ7vURKQpVFLEdyCYyklKU467wPUX4vCfq
	eI3oHUU/5AifkSkqd/ienpDRYpN0HPYGlRk7vq335MvLoyIrC0+p7oTPEBQZgf+7ap2ZTcSC7rQ
	afCFH3M3xbbrfJoLJP9VUGKM427NpJojKDCp81iJa+mJkBPV1buG72b8oUwSfZekSG/1/q97xp4
	T9Ih2F8=
X-Received: by 2002:a05:622a:1646:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50dc22a8b4dmr34916481cf.48.1775718801154; Thu, 09 Apr 2026
 00:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409013246.2051746-1-ashutoshdesai993@gmail.com>
In-Reply-To: <20260409013246.2051746-1-ashutoshdesai993@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:13:08 -0700
X-Gm-Features: AQROBzBgm54MYQPAvx4xSHJ4oCxEzanS_DwtWNC9T2qlEb7Lk6iw4a95H8iRfTE
Message-ID: <CANn89iJTzuhz4izn2rQvAXcm4QR64wwk=3D_Gieuq5Fr83o42Q@mail.gmail.com>
Subject: Re: [PATCH] rose: fix OOB read on short CLEAR REQUEST frames.
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276859-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3BE833C6DDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 6:32=E2=80=AFPM Ashutosh Desai
<ashutoshdesai993@gmail.com> wrote:
>
> rose_process_rx_frame() dispatches to state machines after calling
> rose_decode(), but does not verify the frame is long enough before
> doing so. All five state machine handlers read skb->data[3] and
> skb->data[4] (cause and diagnostic bytes) when handling a
> ROSE_CLEAR_REQUEST frame, yet the only upstream length check is
> ROSE_MIN_LEN (3 bytes) in rose_route_frame().
>
> A crafted 3-byte ROSE CLEAR REQUEST frame (bytes: GFI/LCI-high,
> LCI-low, 0x13) passes the minimum length gate and reaches the state
> machines, where skb->data[3] and skb->data[4] are read one and two
> bytes past the valid buffer respectively.
>
> Add a check in rose_process_rx_frame() that drops any CLEAR REQUEST
> frame shorter than 5 bytes (3-byte header + cause + diagnostic),
> covering all five state machines with a single guard.
>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
>  net/rose/rose_in.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
> index 0276b393f..1ac9a6aee 100644
> --- a/net/rose/rose_in.c
> +++ b/net/rose/rose_in.c
> @@ -271,6 +271,11 @@ int rose_process_rx_frame(struct sock *sk, struct sk=
_buff *skb)
>
>         frametype =3D rose_decode(skb, &ns, &nr, &q, &d, &m);
>
> +       if (frametype =3D=3D ROSE_CLEAR_REQUEST && skb->len < 5) {
> +               kfree_skb(skb);
> +               return 0;
> +       }
> +

Same answer: Testing skb->len alone is not enough.

skbs can have fragments, pskb_may_pull() or skb_linearize() would be needed=
.

