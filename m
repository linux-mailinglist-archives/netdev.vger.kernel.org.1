Return-Path: <netdev+bounces-286041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B2UAJxs/mkgqgAAu9opvQ
	(envelope-from <netdev+bounces-286041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C14FC9AA
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63F1C3023D9E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C013ACA54;
	Fri,  8 May 2026 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5NtOV8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B53A9D8C
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281618; cv=pass; b=NkZgBU4w+NQQ4DiLWK6I0Z9xqKSfS8SvA/vqNgzWllAgFBQqFn/NbaafO3Ea7rBLgr0PaqnOKRvZImotazgw64qlnahPEx+Y+JrWvKZvbwZdssuPakapTTDH6Jfbco7bFPK1pH/Rr2yIM9/b/BfjxnYjU3eHKTBOm4gttBwgWuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281618; c=relaxed/simple;
	bh=KrxWxosUOv+uBNste9BJpa15lluOY3JLm5njohVGVGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a81xNUUfeEhhkX6xrRHTbQscK+RnE74C/tkAbeAUmR5zE/xtkIpphuzxD8OXnPeUybw/wybhx6G4ZRjKLmxjN/dLtEjuRnqRMZcmL9POZd/oLQT8R4g0bLiXhqaUEliehWQQxv6RzwQXnUpuTSbAD8BJsCylrBDVkkAWsO26YOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5NtOV8B; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-393a44854d2so18857791fa.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 16:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778281615; cv=none;
        d=google.com; s=arc-20240605;
        b=cZfVsZXHiQEgZsf6DKAOWWPblglGIFxFLEBelma+Ao8VJaOVtZ6tuOmanftPa/C2Ym
         VSvRSFYGgWhVPErfW3b3T/EwwGuaH2SXOCjIR163+3O6qQS8tEBqXalxOct+6hhej0I6
         mV2o35YUWhtMOXbWxTPfIHWLV8z7FNxDRjuvTIar0KKkvdD8FDkgFgXwPxZKYD5fv4KM
         UZ0D42XdkEsiIYSoadCKfBHH2IhszmwKjySjPSuw1M6DGtDEcTwIfY9JQJIM0aO84tUW
         +e9vgHjV4BcdD2pXtx4r+x1Uf9icXoEEa7K8rkt5keC7dY0k2gd8ApxBlH8NdzYLZFUT
         WJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjzEfq7F3/kgZN4tLvVENq0DffBa4fv6U1JwqNXOSRk=;
        fh=+e28juTiwwZIYiNBqxMMP5iioLiF87cf0TEhKlqUjEA=;
        b=CoR9LSq/g4gmCSjszbfiskG98iNyvCMhzBn4odAS7Ozo8hW+7H8xBs7ximWvY4zjmx
         h7UQgCAm1AslRcN/khsD1/Lmw+vFuTJF+MocaCSnINdl/NS9jAskYxPvmOEwMH0RoRDI
         poI7Td9Ks9faAQao4DVU7je5xsW7cT+zBzweUwlVE0HvdbQ8SmXtj3xVVtiZm0+aJLaa
         Cl+jBqWxSzvMcTlSp8PmsAiiDFCe8FfFJ8WUz0v335yniQTM41qQZVgDy6TG572kzX2v
         vlwn2+rx7uqemyzTRMGpj8iUit9ug/PZyK5G0jouI5V289X6BDkMZHxq5xF076nMKtuk
         oz3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778281615; x=1778886415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjzEfq7F3/kgZN4tLvVENq0DffBa4fv6U1JwqNXOSRk=;
        b=b5NtOV8BHYQPDmCSksqV9TtYXRuJWI6K7ekg+DIffkqd4JD/1ucqGOMwIKh7qUOx/X
         eJvW5F5cIOXYU6a+gdbt4D4oafrQNmYa6nw6Y4yR6/8jxDDLic4nd7CC+p7KCwEt3Omx
         ciBJ4ucF+kwYhrErzdRFjsAC2vXdbk6Rn6mTVeSWFediE1BdA7B2B8il5lYkDVabBi4/
         pYXntaMZTLnRdvcCcgGv+arc66m2Km6/mL4z9oRY+SGz0YSv4kxnG/ivfbeDrL+Ul+z+
         I8qN5ObgYwpC2sBiVi1JYrDYJDS2tB900+bKSt8LnLKhRQxjGRXulxVMQVUOufYLLois
         fDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281615; x=1778886415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjzEfq7F3/kgZN4tLvVENq0DffBa4fv6U1JwqNXOSRk=;
        b=F5x5TYqWdlICd2iJxL+C85J0bj+StBcGCtiOYalCJD/K4Ba3k5DwHWJ6pu0fVjSWE9
         Kz6eEZqINElGT4em6O8W7eYUD1I1tzwqvEqRLfBAdN6NYbGpMoQJayjkmNrwkOl11x/z
         oDE9SZl13A2GhnJmuvBn3xfweCUmAlWc3/E++8ASWPbw6BJCGrlYX7qPrKgkVBWEkJIA
         wiG6Vi1OVEKC4+JP1x9b1mTBs8lPOclyRoBrrVIBaSIbTqaIZYO6nsH2rslhiOLJ4s/M
         c4rHCmGhkiLfpqr5aL8U4+D5jIKgHExxvdqFu8VXAqN3V9ZerYb7h0ftLeyzFW8lh3fZ
         641g==
X-Gm-Message-State: AOJu0YzQzliQ+4b4XpSoLAOKejNsyH6sBBoidp1c94ONOxlZ34poGTSt
	HwiK8bx34x8hPfnSoIC5tOnqmSnAscP+FdpPKgXErROm4k+mxqWs8grRJ4iSTf6D0su0ZpPuMfh
	RPTd6nsFS1R7uWp838cjzHooRqayO3AdT6aMe1rsp
X-Gm-Gg: Acq92OF4Srv+yUFedCDTN58v9I9XtPRwxhaZlyDYWaJec8VhEX+l9b89SSbEYR7FPRX
	MZkUlZ3KZhdMWWf+QV8eBvRdyRebL5AtUamG9U4PtIddk83wyHh6cP+4FrAKj+NxKqr2pHr0jYO
	LhzhbEy8Uwx0UcJwBogG5rPwtjX8E4vfotP36anVJMbT/OsnMoLwfxc2zzOhWJzZkzxTfh6Zopb
	vP1huymA67TSg2RZoogYuEowjV2c6DzeJK8i7hwL0N1AAfeKynFHPq+pk3vBAseMFfKXp1IpE1G
	iE823uE5gyXmA7yowtE=
X-Received: by 2002:a2e:bcce:0:b0:38b:e6c7:2c4d with SMTP id
 38308e7fff4ca-39408060bf5mr568971fa.12.1778281614184; Fri, 08 May 2026
 16:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501012507.461044-1-boolli@google.com>
In-Reply-To: <20260501012507.461044-1-boolli@google.com>
From: Li Li <boolli@google.com>
Date: Fri, 8 May 2026 16:06:38 -0700
X-Gm-Features: AVHnY4KMv_JBo-afcJqBXs1Ubgk2KEOb3vvBl4wjuX7sgqTgfuyIJr7897EYiKI
Message-ID: <CAODvEq7D75chNgD3h5w0rfa1ZFgca9VEd54sp4Ww999gCed=Aw@mail.gmail.com>
Subject: Re: [PATCH iwl-next v4] libie: log more info when virtchnl fails
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 684C14FC9AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286041-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Friendly ping on this patch.

Please let me know if you have any questions regarding this patch, thank yo=
u!

Li

On Thu, Apr 30, 2026 at 6:25=E2=80=AFPM Li Li <boolli@google.com> wrote:
>
> Virtchnl failures can be hard to debug without logs. Logging the details
> of virtchnl transactions can be useful for debugging virtchnl-related
> issues.
>
> Tested: Built & booted on a test machine and synthetically produced a
> virtual failure to produce the following log:
>
> idpf 0000:01:00.0: Non-zero virtchnl ret val 6 (msg op: 1, data_len: 8);
> xn id: 0, cookie: 0
> idpf 0000:01:00.0: Transaction failed (op 1, xn state:
> 3, id: 0, cookie: 0, size: 8)
>
> Signed-off-by: Li Li <boolli@google.com>
> ---
> v4:
>  - Simplify logging to reduce redundant "ret val"s.
>  - Use %u for xn->state.
> v3:
>  - Use dev_err_ratelimited in both logs.
>  - Move log placement to after virtchnl field validation.
>  - Remove redundant op/cookie fields since they were validated.
> v2:
>  - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
>    reviewer feedback.
>  drivers/net/ethernet/intel/libie/controlq.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/et=
hernet/intel/libie/controlq.c
> index ebc05355e39d..e1bc19d6cdbf 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -766,6 +766,14 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv=
_params *params,
>             msg_cookie !=3D xn->cookie)
>                 return false;
>
> +       if (ctlq_msg->chnl_retval) {
> +               dev_err_ratelimited(
> +                       params->ctlq->dev,
> +                       "Non-zero virtchnl ret val %u (msg op: %u, data_l=
en: %u); xn id: %u, cookie: %u\n",
> +                       ctlq_msg->chnl_retval, ctlq_msg->chnl_opcode,
> +                       ctlq_msg->data_len, xn->index, xn->cookie);
> +       }
> +
>         spin_lock(&xn->xn_lock);
>         if (xn->state !=3D LIBIE_CTLQ_XN_ASYNC &&
>             xn->state !=3D LIBIE_CTLQ_XN_WAITING) {
> @@ -1011,6 +1019,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_p=
arams *params)
>                 params->recv_mem =3D xn->recv_mem;
>                 break;
>         default:
> +               dev_err_ratelimited(
> +                       params->ctlq->dev,
> +                       "Transaction failed (op %u, xn state: %u, id: %u,=
 cookie: %u, size: %zu)\n",
> +                       params->chnl_opcode, xn->state, xn->index, xn->co=
okie,
> +                       xn->recv_mem.iov_len);
>                 ret =3D -EBADMSG;
>                 break;
>         }
> --
> 2.54.0.545.g6539524ca2-goog
>

