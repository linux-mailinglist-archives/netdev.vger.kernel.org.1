Return-Path: <netdev+bounces-301322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L9D1OSVYOmpn6gcAu9opvQ
	(envelope-from <netdev+bounces-301322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C606B5F89
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:55:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=H1FneK13;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301322-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D153011048
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DD369999;
	Tue, 23 Jun 2026 09:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDA369D59
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:55:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208544; cv=pass; b=pcfk4m2JS+K9q0nXb5+gGISbXHnXUr+jPQB7Zd4UUKZhW6OdnuxrxHUR8R1PX27T0AVEgjByT9Te/7axx18LQjvouqiWsKdl9rn3E1YZS4gKxWVBgQallLdkn9aCaQJ5OZhx5kJ97R61StIpcHVkpZK08Z23PnjX0mAxiR5LJhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208544; c=relaxed/simple;
	bh=LvYUThQne3TrY6uaQG9EmEyHuxSQP+aNbK640K+aMxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4PeWghiMsoxHJPJIa1xa/3Vf4MQgP/Py+c/oLU8qSLceYChF8hgZbhb7lXJALBlTM7X3vtRpiIpGPMdMfeMX/Jv9rENBkrRPeBxynOm1JXz+YbMpavBkvT3xe8K3sYbCfGGBFBJK/uec7+oVWhbETFgdt+w8hOQpsQuh+FTxmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1FneK13; arc=pass smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8dd74f90e3eso61795936d6.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782208542; cv=none;
        d=google.com; s=arc-20240605;
        b=U6RT4S/lkSWdZZdQlK74ybLTixbQSV96GqLJT+21syqBdZU6sQneO+t/tY1C6Z11DK
         dYjkQh7JHY6oYLStZkdXsWf9g9JL65hXQvVp7wn2cI4TCpkswOEquNONAuQC59ioyahu
         T5qThVC13Ev4wOs3B+rXriOhp3Cc7kZ80Ode0W+cj9ZNPW6xkIZWWGPGBaEeBE7gQE2W
         /ZO7/XfGFXmjX4IcsAYpEHgNBNqS3ERy/1myfI//kvbA7RBNi70nrZdTJcxqVVXv3NSR
         7bF+v27Rj/wCZx3WtF8w6VPd69ZJLpiOKp06MP1p48VtYuAuEUG0/ZoS8KW7ZcRP3icg
         W3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        fh=RcSVRXhuFcqFbUIdcnEIqftHOAz6yBvvd9QhOMjwmiI=;
        b=Zmv6AHv1v4P+ZdRxJyPgjTrBZAVLt9ep5eAyJL+k+nXFSIhb20XuwozNBbjColGGyu
         cYQIdGAM38+Pivads34weiv+o17uLkDPchi2/JFKDhfGvzJKigHvKVX1rIOPxTWFIuAA
         j2GSoxjoRTSbJaltH1C1ePsAruCXSLMdAQ5n+U/Gvfy0jrHKRiduCyRO4tMA1ASGuxcV
         g1lffGxVVAosZ1Tw3+NJFk7EGS2aVK9rvjBAeftgJn+7K3+etp6t9IFHYp1z3cz1kG2U
         EdSgIm0tUvwIWRMVF6fw9616mHy0AXkhD6X5G/rvIN7pe2QMEslmjc0dIN7KB1ezEGKH
         yLsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782208542; x=1782813342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        b=H1FneK13MT19e+Ln7/c4eyYiN8gUjdB7OjoiAfMZ/itau45v5A1avaCJZxgoPNt/Up
         VMsX3cnYiyA/4mTLe+3eIEmtqFudhtSEZddiQ+SsmJZfjCAGbVuBdxbF5rxOlhkk21A/
         UOCMaJBFqh6qsv2TwaJj6ZTFFzAirz3RcJwDz3gWeQpiS5sMYJsMUyMt2ARpTLYb+RB8
         AMWpZMu+44lGLjm9Al3exiQf656J42rJTn0MJ3a/9+NkUJULSGnqdFqYIv1IekE/dqp5
         5TjL3GaFpNcSgJMxK8sa2zmeNhjuvK4+H2/xUGAgyW4iU4g3q4Tf5IhalAepClBpOphb
         Cajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208542; x=1782813342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        b=MCDPUMcoXWowg+uX+sAGrh9Q7dtfmBjC5LW+yl0EwjhimPeD8o/er/yMw3F73IDN92
         kqwxpCamTPbcJSVbWsJVQKbR716lsWSbifgYq8zeTEP5bUqCI5BfNFDObK7BADd5Nm+d
         k+GzSSjrLj7KQHQkWYVJkz2fgwySa8Vn+PCZYayMU6MNbNMhlU1njOEH/tHKHPXuK1lt
         gqBn7jgRR53Na8u+RfE4cKRRlKOnH3PZYaW9l/NkevaLHQMqdayC9UYwzLuZ2F7OSjJ8
         JorlEHfV8eqLnthaIrz7xZoToObLlcdCzcyMHMk4z/RZvx7fKAPA6efkNvKFvEa7X6Cl
         8M6g==
X-Forwarded-Encrypted: i=1; AFNElJ+xHGxIlt6c3SShl4mV7/Sraql4m/U+UiBD57ubFPhMX54KHULbIPcg8w6PPrJE+7rFgHBbxSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YHNPcZpksq7gQo6Dniq6Od6VS0K0l+BMvxQHbdyoTvVuZzeX
	lbjwULqe+YpjtjBkPxsu7A3HpPLAKositdm45ABvvVF6sUxP2dZCkUq8tCodGcAzsp/JGwOJ3Mi
	i/xle8FwYntKOPR+L5q+pZmu5eRscmgUxTxVCj9cJ
X-Gm-Gg: AfdE7ckN1qlX4UKapB7W8Us8e4Ztmc66a//frhCI9WGaOYDr3T3cuIt0dUJqJerq8H+
	ZSfbR4cUzoB/nxPbKXUtNRaZ1446HMBjoKY9AHmEDPcgm+kcmFlN6+wGolSVLxWYdEpAhniTf5e
	cj/2my4F9Accmp3RWz7pKTJMr/lg76qHp5hBMi0olC+BtQGAKvBg6xpI6PlOiJ1QV8tIwD+GV0f
	dpm4rz7TJ2LAxsrLfjccppp/hgzDX97fKahESKVflSzz4zbqP569NfGYxEMVzLbn5oE9CEvWX3h
	aycV2Yp82GOUUG0YgR/UgHlumuIliAqqm4CH7lkRTc6Wf7QJj8CRmuDXVGm2t8TFLThi0hePY8o
	iogfh8R83
X-Received: by 2002:a05:622a:291:b0:517:5e32:f3ad with SMTP id
 d75a77b69052e-51a06937e84mr204781371cf.26.1782208541730; Tue, 23 Jun 2026
 02:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623091901.118315-1-lange_tang@163.com>
In-Reply-To: <20260623091901.118315-1-lange_tang@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jun 2026 02:55:30 -0700
X-Gm-Features: AVVi8CdxKu-26NNasQTWpoEm4a53c3jWCLNr8S1zeEbZh07qmL6p3AGRUsDetT0
Message-ID: <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
To: Longjun Tang <lange_tang@163.com>, netdev <netdev@vger.kernel.org>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, 
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lange_tang@163.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:virtualization@lists.linux.dev,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301322-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56C606B5F89

On Tue, Jun 23, 2026 at 2:19=E2=80=AFAM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received =3D=3D budget), it will lead to a large number
> of spurious interrupts.
>
> Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> the callback off while we poll and re-enable by virtqueue_napi_complete()
> when going idle.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
>

I added netdev@ to get more attention from networking napi polling experts,

Please add a Fixes: tag as this will ease code review.

My rough guess is:

Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")

Thanks.

> ---
> V1 -> V2: Remain agnostic to busy polling
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..0a11f2b32500 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>         unsigned int xdp_xmit =3D 0;
>         bool napi_complete;
>
> +       /* Keep callbacks suppressed for the duration of this poll,
> +        * busy-poll need.
> +        */
> +       virtqueue_disable_cb(rq->vq);
> +
>         virtnet_poll_cleantx(rq, budget);
>
>         received =3D virtnet_receive(rq, budget, &xdp_xmit);
> --
> 2.43.0
>

