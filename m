Return-Path: <netdev+bounces-268833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICBmE1juuWnPPgIAu9opvQ
	(envelope-from <netdev+bounces-268833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:14:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E92B4963
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829E930610E8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7E7083C;
	Wed, 18 Mar 2026 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cacIxvzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14029CE1
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792728; cv=pass; b=HxdClfMftAoWpuuPZeo7hrbPu4KsCB0ymyKnCoLQs6rthLX6qe5YvwXASD6IiO32eOAUUwLxMhe7B+h5Zjtak9jQxpKXPiuWDilSUaOFGJhAR6KnXPcTpPZQEAdT24cGZoF3aJ8o78kz1p6ZauW5/e7dBVvGOxYtBdTAuWbKNM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792728; c=relaxed/simple;
	bh=knEiv//4VD9jJeec8RxNBDwCYflHSFiOuljpRQD29hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjn5m6s9hZfNW5oWsRRoChaVtJoxOB0iEF4ueg0SDSYmN9FIactjmZOGFLYJST0T4Tz2glevi6iIQEBs1BtJ5TD4RX/JHvK9CaAwtGl2wXj2/nUT7kXIWyXR/oqxtPiJTwmGbkw5+6FAqmFQ3h1WJIAJy8O9YdlxUvcMuniRPM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cacIxvzn; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad019bbd4so6603083d50.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792725; cv=none;
        d=google.com; s=arc-20240605;
        b=ET6g9aGHXmwj45NCKp++upBlRohYqQ0L/5SlurhyBpWgOZhQqbUnnJckMIoCLGFzsd
         thT1XzHaGK9hTvsYy3R4deCHHTsLD/glVezaYZV15RZGW2vKrTCA7sjUb12rXIyenLOG
         cDF3mcx4w/ERXrBlwcB5uiWnQwgCH6ioZloUwJvTRN3rJJuFjh2yPZoq/6mSNXSjac6x
         wvXycwEOJClcSjK7y56zlOtBmus1KWc10hfbsUn7fChQZt787qVGMPYm0r0jLEeWf7Ty
         ZA2fQraPGwyHUNv4BXbNNnBBMMeflprTBRog/DF79O3r5obVN3m6bAfv+qumj+S39jO6
         0LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        fh=dEECgN0TBTdssiqHE5H4uKtW0i2WaKfRp1GriC+bAnY=;
        b=b7I21UjUwk2jZfnQDrvP7D/7IAFR+QmYetPKRkPU6UrRzTZcxCRNLiO713rhwv0dPF
         q826qBjGysrm9MsbPvTxnLWAD1odsV2oaLZMHlEK5cWoVbQ4a4Olydx7UxB9aAH/YuWL
         fJKrcoI1CzE1uyryt6az7A8qwOE78Lh4S8jjNsfdMKDRWM21V51uqOsytVx6q31U5ZiV
         1Z5vamvMSf0mDZHq8mwDIPIPwtsw8Go+DvjEpNUPOkBAiMIqAYMDfkSGkbYiosDx/wnN
         RL9PMrMuCPQVIUi2xGRSJm77J2homyg2xJXRtAYYj+yu9uEPUyamtvh4+6QDPwevzngO
         sPWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773792725; x=1774397525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        b=cacIxvznXQG7bp+7541HnDPzgFd84zk+LVG1V3U1bWO0/mCXkh+ExFNXX2o8HlOj1k
         yoifAmkcEGizBeFhcMj461HFHH4stRh6HUEsa4OalKTQKQkIHjD21IgltlzDKBGSunnN
         QivfLibwiw7hI430xMUnLu7IYMG3YTIZr24CJjO5wcJo3rZqoa6wruv/4ol09thdF+qs
         ROp2fN4kFwCo3FEpeUOVHbk+o+qbIsSxHPV42XKC7qqEtkV0o6V1p5Z8MVA/MfNeIG2v
         QiWSzys/uri6pHn+9/J345kVCn/7i41TJk9e3QxnMrfn6ra5dEG+JPhIQWUY0MZd5dVd
         FWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792725; x=1774397525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        b=HVlE8ox0CWs2xOzCuCuP3dwbx0gbmZGSy8fCGYQvoDClk4If4mxhJ+yzw/FYd/iMod
         P8ZUEZ/G93FLhpZa17Ygk8eMegmmwp3HN6buDDYjkIGv8+/SZHV1LLYD6gEB08i4imqV
         9i/AdMMHsRsvq2BfghDhlShynApXtCFlJyjKfiZ30uMRk0o1bjr0vCioMGbVvWrJZQHX
         aNZMdzOZ7gC6TRj6VfcBX0aAY3lNZCLhJ1LF/Sqsr4ayA9pfDVabSDE/MgvvMuiTvSNU
         j/Qvausu2jxSkJI4QcrvA4XtapNzSCLnk69TXYvAkCMdVA61cW1PRxjOA5nffNUmnr+w
         Rzag==
X-Forwarded-Encrypted: i=1; AJvYcCU2h+RaYa+JjtsaS7KG9EmtqzYfNQ2sJmOhqfbrmzQyTVS0tIA73wZFYjkJCsqusfyxhToRFSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnR/jP7jo7J9SSEXGixH/qTphuKUMvz0oITctM0iupnS5I71zZ
	DzDUrqOYZ+bSfHUV/9NTnSStxTgclyRrqoKTzWMr5wSciSiVP+u+jWjD6LjeeH8Uc0pYdxRxZgx
	OEt+OIr08JEp7xR9shTa5kgzKklkOa6B1e9/XTXl4
X-Gm-Gg: ATEYQzyqFI3iDSRN+/eqkzNb25xcKhgnRHMq0g/dvvQxqLOwlJwpdy2dDhiCtzenBe5
	f0zbkjVPR7+51JI+i7p5/L5eiorXbdJjIOCBEL6Ye80oU2O89ns2y3znI8c62MF3riS0jpcsxpO
	vsWc9hmegu+UM/dJTyDyPFVn+7Bug6+QQq+7D3XqBpsl8tIzZSPKLEECvWt6uW3CC5HyP5V/dMh
	o+RtJ+SGbGqJ7vprw5gfk0RwBB6WneQvfpKEU5DH4taTlAgGzmp6vmdsqiZYRvonLSTG2YMpd58
	OF7pYEVGU/CfKxnIImcDrmifks3C4geORFQ=
X-Received: by 2002:a53:edc1:0:b0:64c:a4ab:e4e8 with SMTP id
 956f58d0204a3-64e91327c01mr1498946d50.20.1773792724985; Tue, 17 Mar 2026
 17:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-3-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-3-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 17:11:52 -0700
X-Gm-Features: AaiRm51lAT37d5orb_kuGVpaQVhsFcoQau7SuZhTPMn1qsiJkxQa_jxj52FffUI
Message-ID: <CAODvEq7Ty-D6MPeS0r3077jXWMX0i9yp3UB7d+mnGTaQGegH-g@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/3] idpf: set the payload size before calling the
 async handler
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	linux-rt-devel@lists.linux.dev, sgzhang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268833-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BC3E92B4963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Set the payload size before forwarding the reply to the async handler.
> Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
> will never get past the size check.
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 21a6c9d22085..6b9692b30040 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -627,6 +627,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapte=
r,
>                 err =3D -ENXIO;
>                 goto out_unlock;
>         case IDPF_VC_XN_ASYNC:

Optional comment: could we only set the size if ctlq_msg->data_len >
0, in case the hw returns some invalid values?

> +               /* Set reply_sz from the actual payload so that async_han=
dler
> +                * can evaluate the response.
> +                */
> +               xn->reply_sz =3D ctlq_msg->data_len;
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
>                 idpf_vc_xn_unlock(xn);
>                 idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> --
> 2.37.3
>

Reviewed-by: Li Li <boolli@google.com>

