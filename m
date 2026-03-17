Return-Path: <netdev+bounces-268618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DiLCWZguWlsCwIAu9opvQ
	(envelope-from <netdev+bounces-268618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:08:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA22AB7BE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37E4A301AE7F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C53E3142;
	Tue, 17 Mar 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXlTXoT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F23ACA43
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756225; cv=pass; b=DlGD9PwhKTg0JTOMyeNkE/za4d9w+ncFBx4MhfZjFhuy0EX7/wDKEuV4d9J8uZa4ansNBnIcGfp+9E9dRTJU1dRqX107DTjOKbLu6oDNNbBQ8XOya/xrjf4261KMOsfvRDzeZJUQIgAMq8DpY9cRSM1/6noONffPQASYd+LmVww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756225; c=relaxed/simple;
	bh=bHqLLs/9sFWvIV0+VuBwONWdIQRlmR6TQ2B2OYKGYQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgIzI6TmYOBBPJKBV0sEewnkEembTj5lyn6DgebH0XnFFI6TNLryFofvt+yFXi0EhRp8OOiGFE8fc2nQi685n92MqWDf+zxRQCPWDzOgsfsTDyYsgxx31U4+IdZgkjEDXr73mrYbngTIaOH9GG5y8U7rJFlPGImTlHWYDo4jj2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXlTXoT+; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a10d130b37so713297e87.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756221; cv=none;
        d=google.com; s=arc-20240605;
        b=VVwelM/lXJC4WuyKKAu0kt/nGM13fnQbzbo3z50931GkkR2NQ5muzyYsrHqxJ8k3r+
         KGuCNissurpOTA7/QH2jNna/PqOH2Y3vWy1Qi+5p56LgWdXf21mZgroAohl1+g5+50d4
         A0vyyLGdmDPIzNqwxz4g7FmzB6jVp0NThHvvgR88QGoLr9Ha+MZeMuMbNKX3fvlJNmZS
         lQ8uWHGNMiik1EHsADHzHv7oJjD2cRjM8dSOE+MVgg1qYHWr+XShPVnEkX2UQ9yK2PFk
         iGRsVR/Xu35TP2VZ3bbp97ZkrO7449wzaHVLlxVFqx5jFqptNWVxIbOUgfa9eHxR97xn
         ebLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        fh=M95paEaCS1UgEXIb0Mz+O9sWK2FXbtwJIcqr5C4hXUg=;
        b=hfUgPSijoluQxI7VnAAC1+dbBIMkZqlfcZvbGCaakrVjXkdh2UQTDZ4dxlnQdYunVG
         D/1uQk3vhJdDHeSP1NyRlzbfuFWalHXdg5/nRXzRUhof0bctDxtyz3wATRT3uqkmWnYf
         w9R7UAwDMpMxnd8ykbCxSsMxu1ugPg9QC3McZDiEYgBpnxGZmRIT+Kc88uKq7Df2eEB0
         RFLyMKYQdt10Q4a2xCO0BIiFOqtZBdvU9281X3vZ5FJsSQGqXTEweu0I0hltlTRCgxPq
         0AoMlZuuChwnFtpke8oGgJ4BeCgUth+jG8trel50zO3+5Gx3gRq02KOtg6ZxzC9rQ1Wx
         25zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756221; x=1774361021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        b=KXlTXoT+gjnAk/FMQ+yJ5GslHzTnuNE+0hOJ709cBfrx8uxhL+hZ4i+UgAZVUm1KcI
         yhMh/Hp183ZFEwN0RlngbnLHw1oUaUTEw1FQDQY+xag+/8SDt+tgnyDBC0rmqenBT3Q9
         bZCZJ1KO0T/wXCBOMnAiEVQ7ss59b2iXMtOTZUtLivwhxI6u2i5Aji5CiY7Fs6VD7MsR
         DRdKN2AvIrxBiijSkQ/IUhF2y6PkxNKO2fQ+MhRAOIJlMlOJkWpgx8hrf7hlCdMov2wm
         rDzocy4L0lWWUj2ZpFoS5N3wk+RmqssD7ZYCX2aCZbmMJRDchR/WdsTOmjaWXeHhz6xd
         PO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756221; x=1774361021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/3f58iu/+g/g9Goo1LOfp9JAw9bH8W31yo1xCwf7o0=;
        b=MKDitK+1yaMMQUVbmOMP7BwKyD7LtbJO/uuIS2jetU13w0qV/yzL9MYkgdGvXlWk/7
         KQlpgoEA2kcVJ7zJR1vjRZQXfewAN//pDqu4kGoV0G/2xUY9lBzRQC473d6uwv43slQl
         NN9qagmETMoYINVRcWUy4WCN70nh3d7IMuL1pQp52taYFaJcDUweaU2KW7dSPclcFhHG
         DcKxi1gxJXFKdi6OMwjpDYr1PI2hcmpsoTaN6Y+dw8DWiFNMtI8ASIOWFbiSO8eQGy2c
         6ARDgV0VYRM530QMgDsr7o0GgMegbtQdaUY5Zk8+LMFBUG1TMu9ryM5b0k79Vgp1vild
         NUCg==
X-Gm-Message-State: AOJu0Yw2b1DE+6XnTUAhfdrhx2OWz2DNqatUekwNgDOPWx37WkKjy/Wt
	LatPdWMr/wJZclkH8IzmYSBHHqgOwSbH73cHm1xyX9UimfnNsXm8dZSrCcUYzrDbELsYCTYAJ3T
	NU8CzFSKR4XmzNbPcrUVZE7UHt/DDF/4I5j3rwErCubk8aIVlatTVxWgE
X-Gm-Gg: ATEYQzyBnKkME0+TMal2utIaFkG4juiQv8iSd39TYNdxVRD1NcqkJkE5BthocrI9tqA
	KT2l8Tf9jRZv8CwSQvOp+bs7DfjLJ+XBkT3XExa9M2AZAaAA6+8Bg1ygp3/FSw8Ga885lRGMcrY
	QQj6CHvqc+Gqly04B/Ehm6fTMk1rt4On8eBlyiE1RYI83dAgRyXMpt6iFnm1PxJ0AhEknIo8bGC
	r+gkAby7NraXMSkt/qQD38pTKE2wt7GX/2vEtN5P7Fj4soTZ3mMMy5qEb/MOvPwKhUOQB7aSjKM
	2wxMtl2btwO4lPU32hsVyZjjLLLGNICI9elRrjehuR/AyK5oHpI=
X-Received: by 2002:a05:6512:61c6:20b0:5a1:3deb:c073 with SMTP id
 2adb3069b0e04-5a173b9c0famr983817e87.1.1773756220885; Tue, 17 Mar 2026
 07:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316230434.1398828-1-joshwash@google.com>
In-Reply-To: <20260316230434.1398828-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 17 Mar 2026 09:03:28 -0500
X-Gm-Features: AaiRm53yfwWdQK9oY-u9T0Uwef3SLxbw8OQA83QC-nJ5xodPhrctAZuW02VZjwU
Message-ID: <CALuQH+WVSVuan2WRtnugnWo0ZK7dG4Z6BWgHQVULb6m5TZ7vrA@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: add XDP metadata support for DQ RDA
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BAA22AB7BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, the commit referenced here should have been
1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode"). I had
mistakenly drawn the hash from a different repo. I can respin this
change once others have reviewed it and left potential feedback.


On Mon, Mar 16, 2026 at 6:04=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> Commit daa7ff1e1269 ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> exposes support for the XDP RX timestamping metadata operation in the DQ
> RDA mode. While the operation works on its own, the intent was to enable
> XDP metadata support for the queue format as a whole along with it.
> Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
> This change updates xdp_buff preparation to set meta_valid to true, so
> metadata can be fully used by XDP programs.
>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 7924dce719e2..48945b4b6766 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struc=
t gve_rx_ring *rx,
>                                  buf_state->page_info.page_address +
>                                  buf_state->page_info.page_offset,
>                                  buf_state->page_info.pad,
> -                                buf_len, false);
> +                                buf_len, true);
>                 gve_xdp.gve =3D priv;
>                 gve_xdp.compl_desc =3D compl_desc;
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>


--

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

