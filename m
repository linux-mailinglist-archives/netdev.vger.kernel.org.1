Return-Path: <netdev+bounces-268820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH1uMyLouWncPQIAu9opvQ
	(envelope-from <netdev+bounces-268820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:47:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343082B473C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB6A30C3DA2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD683A6F16;
	Tue, 17 Mar 2026 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gowGjarR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4A345CC0
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791230; cv=pass; b=ChSjWpuFjcoFivoH2z87Nunsx0lv9BJdxyBmzECwRi6LUUutDIJ7wnkee4iGiObd/ToIb+/7xwHdfVzl71z6XP+8n4zI/CorLH/DGZoCgGor/ocWOKv654ZEVQkXHe+PSB3G7b5SgUNporXRrp+Od0MiogoOtNUBbHBEg5r/P44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791230; c=relaxed/simple;
	bh=7FEO+WO9gtmeaYRXFXZeU+isk6gKICBV5TmJ0jQgtTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqKswcAJrQMMJK7LYwCqsi9vFOp18eoQ8fiGUObV8T/KTJduhSIJwt5+d4gQQ1wsqt8a7JY+D8Dcejg87cDDhT1E2f6lSot33mUVanJ81KQ2joeIv1pCVUgzi5qC0ElLGFBV1/VZRHB1B9P6XFHviLtLy3q0/tXOn7MZOrzw6+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gowGjarR; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64acd19e1dfso222873d50.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773791228; cv=none;
        d=google.com; s=arc-20240605;
        b=hu/SVEXRgFfl0tO5Vhofq4A6A7BNvHa2rJXvh//SspRGaXQmRdVRs9qejkzEGKOac4
         nE335sCx/nJsCnTikAAj1DSwau9t/c+Z71V5xMH367ANSCUBtPAtzzelJvb5Dzb5zk5b
         i7HkpKMYTapPr+TSdtDdD/06Q214fWz3svLc2SFnnFxhWl/YPeOrB99Tl/VscfsC+VVB
         7741SwKi07U+uDcDivnpCGfag5Bd2vi28TV064Pkc8sknHfLvbg7WzxiN3ulA5n7Ds6f
         UVIvWTlM2iEQe5Njh/fKdOW8OKYm6MJy14gCLHnA0ogAbqDaAq2OhMKRZMZdHu8RYOGX
         v7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        fh=z75WWYellEsM3U2bt6MHWr0q/shw/DC6CNSP3iNumZw=;
        b=kpIBwJMMxvr3QwNfl0RcPHt/Gjw6KX1IF9UGJNlFD6KoXrru1h1ZKdjhfJjBnNc6GM
         0xiKCyvvnWtZo1iRyDURT3ULjD1tZt5zUtRUmDAgg8gWz2s0LwwdvWSU84l79krcpSy+
         BSVnAjdI5x4hxw3Fl/aciOvQmKQ9aNg3O70aPkIUdwB6R87DJl/hWV5QZ648j7LRpIEN
         UKktKI2J08XOfzWbn4nbpmLETV7HXmpBlmYooSDmiROIp18NK0equGIWzwoS/CtoqMJg
         5i14junpx/B5QH95UgN8xjEOnvYoDPNuV0v4ksxtNXh1htrhXLY4H3FA28k4T6DLMN6W
         bv9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773791228; x=1774396028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        b=gowGjarRXkz5LylayKX1E0niD8BT4AVelRRdFHFkPbLr2x9wwEivM5NNzdIkFQ3JUj
         hrACP3T5u+hV/OMWEnrQcRVE2pyWBX3mFrTACZot4PkZh+zX/ZcLuazxG7kuZGA1+Vaw
         L2maW9oxSTFCo7AOwcKW3rWSqK3YJro8pxU9NtjhBjd1TR9Ao+DEsZ4rKHq7ynHqqmL1
         YA7nWRszUnEbz6RL0wCDj0+c4ox1z5nNuzroAjl28myVvj37CZNgBreXKKsFxNW+u7IR
         5WjCohzjizkBgdXAP6plqCmi+zGvJf+rTaSDtQbqdf518G8q2PB0nKofbWcpXMOKQSQB
         MGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791228; x=1774396028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        b=YOJbzYk8uZciZ3F2PcdFViM+A1cIvwg3wzPj42bj9cMiEYGMEbpen+JM7JsewNXKzf
         w3Yjo8Jihm0SlsXdgqOlZ87UYu2uaj4y/DQ8du0CrA+A5Bg2EYTuWQk42mEStnZKxJGx
         nZa0cp9lhEv/W0WdgU6qeQjz23riv/oaZbRkEQaFcLsY2AU7nRy7OA1yMuQqvicjxhYy
         du86CqEQF8mNc6x0rLP8LZ0+DoLkCu/zfgFTKDtTDI6fEze88E4xIUcT4U42Uvvh1wm5
         /eEfb7uMQ164CFBcACyc7msVGblqR0aGEHMlAq13/Cxfx3wmlB5Hy9PX9f1jz25g5yZX
         oVbg==
X-Forwarded-Encrypted: i=1; AJvYcCVhFo5C53DQlWazKUoFRshETJQE4uTkdLoUNY+IBVr/yy1Ls7BDHulRo5al3dwYl4hlbkXsC54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPCO7Jxkin8Nl3rlUu83bjeSCTK+geYt9CJjm+PDIcP0lo5/I
	W15+kjWDQUUJtcHx9BbpwpRRlbON6dhUe2eVW4b6kTvWrOQureubUw9JK3NyQn5l17pUOnpmK0J
	kFtMhR6Iy0I7cluFzVqI25SBOnVasPwTSHMtTo7WA
X-Gm-Gg: ATEYQzyUeSdTBf8bjHKtwv2+OOoYNfjcCmjyXCjdlqDxpyqJ/ayKnPOS/qn4EU11ijp
	H+ya+OYh0dAoh2Npp6R8Sl0fSAqxd26kfNIY9H/p1gOcdKJVIaRDmqbWEhjUrB7s/i4LvYjRf/L
	15ES++nB4X2ozoQJv8oo1z8XAU2MWG+REfCOnCCaw66+DWQopNBEDYSl5ak3N35ZWUgagi2isCQ
	6Z91ey6JP5AucLcMxBNevyKtA/g5uQ8I1weeD3ZOa00fDhUsafRUuvmNxTLBAq4nLXKXC5456GN
	YV9NwL4ppFDh5Xjc8zFk/DMWDlChfI+j+HQ=
X-Received: by 2002:a05:690e:4492:b0:64c:9fcf:2ad6 with SMTP id
 956f58d0204a3-64e91735a9fmr1320814d50.74.1773791227342; Tue, 17 Mar 2026
 16:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-2-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-2-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 16:46:55 -0700
X-Gm-Features: AaiRm53EgQN0srwPUlGkyxpZzqDPqm7JMjWgqbwuCg88u6Jwx7G7TAITi-bhaOM
Message-ID: <CAODvEq6xHtbtaV_8D0yxWMrBxNryocoB2fvXfvrN-N47FmPZMw@mail.gmail.com>
Subject: Re: [PATCH iwl-net 1/3] idpf: improve locking around idpf_vc_xn_push_free()
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
	TAGGED_FROM(0.00)[bounces-268820-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 343082B473C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed in the previous email, I had an minor & optional comment:

Personally, I think the code would read better if we just get rid of
the push_free state and use 2 separate code paths:

release_and_unlock:
idpf_vc_xn_release_bufs(xn);
idpf_vc_xn_unlock(xn);
idpf_vc_xn_push_free(&adapter->vcxn_mngr, xn);
return retval;

only_unlock:
idpf_vc_xn_unlock(xn);
return retval;

But I don't have strong opinions whether or not the suggestion above
is taken, and the patch LGTM.

Thank you Emil!

Reviewed-by: Li Li <boolli@google.com>



On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Refactor the VC logic dealing with transaction accounting where
> both push and pop_free are using the same spinlock free_xn_bm.
> This resolves potential race when setting and clearing the bits
> in the free_xn_bm bitmask.
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Reported-by: Ray Zhang <sgzhang@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 113ecfc16dd7..21a6c9d22085 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -401,12 +401,18 @@ struct idpf_vc_xn *idpf_vc_xn_pop_free(struct idpf_=
vc_xn_manager *vcxn_mngr)
>   * idpf_vc_xn_push_free - Push a free transaction to free list
>   * @vcxn_mngr: transaction manager to push to
>   * @xn: transaction to push
> + *
> + * Callers must ensure idpf_vc_xn_release_bufs() has been called (under
> + * idpf_vc_xn_lock) before invoking this function. This function must
> + * be called without holding idpf_vc_xn_lock to avoid nesting a sleepabl=
e
> + * spinlock inside a raw_spinlock on PREEMPT_RT kernels.
>   */
>  static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
>                                  struct idpf_vc_xn *xn)
>  {
> -       idpf_vc_xn_release_bufs(xn);
> +       spin_lock_bh(&vcxn_mngr->xn_bm_lock);
>         set_bit(xn->idx, vcxn_mngr->free_xn_bm);
> +       spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
>  }
>
>  /**
> @@ -428,6 +434,7 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
>                         const struct idpf_vc_xn_params *params)
>  {
>         const struct kvec *send_buf =3D &params->send_buf;
> +       bool push_free =3D false;
>         struct idpf_vc_xn *xn;
>         ssize_t retval;
>         u16 cookie;
> @@ -514,10 +521,13 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapte=
r,
>         }
>
>  release_and_unlock:
> -       idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> +       idpf_vc_xn_release_bufs(xn);
> +       push_free =3D true;
>         /* If we receive a VC reply after here, it will be dropped. */
>  only_unlock:
>         idpf_vc_xn_unlock(xn);
> +       if (push_free)
> +               idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>
>         return retval;
>  }
> @@ -559,7 +569,7 @@ idpf_vc_xn_forward_async(struct idpf_adapter *adapter=
, struct idpf_vc_xn *xn,
>         }
>
>  release_bufs:
> -       idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> +       idpf_vc_xn_release_bufs(xn);
>
>         return err;
>  }
> @@ -619,6 +629,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter=
,
>         case IDPF_VC_XN_ASYNC:
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
>                 idpf_vc_xn_unlock(xn);
> +               idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>                 return err;
>         default:
>                 dev_err_ratelimited(&adapter->pdev->dev, "Overwriting VC =
reply (op %d)\n",
> --
> 2.37.3
>

