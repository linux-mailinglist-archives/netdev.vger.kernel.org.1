Return-Path: <netdev+bounces-268377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMXYCJGtuGlvhgEAu9opvQ
	(envelope-from <netdev+bounces-268377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4682A287E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12658300DF71
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB113128CA;
	Tue, 17 Mar 2026 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk2jj4Tf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AA433AD
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710730; cv=none; b=unYku9EgfT/TTekRr8bHKJSrAwrks9JPg/EJhf+5IrKBRZVSOp1Cu770pB2woXL5GSonCvpHI9UN4/x/GLEVOjEFMb4ErMB3TrZlUTwVfBeXJm35UKAWBY1FCuRlVxo8fYhg5Nf8PrN364+P+BBh5u1DfPxaysOLQGIWrYZNqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710730; c=relaxed/simple;
	bh=rsxl2IWzNOzAu6w6/DK6/1xM4qXCu4a43lJZr1tz2uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clYdIAyErxTBbEwhHTzLUnuYWpyXHY9UbstqE1PBqKVpOVHnwgHbTEVbuTThyE/6x36L2V0fT/BLQ0MJH1kSNiDHMfyKK2gdTeJqvuxSlWMPA/RtJN33eustuSdig0bCmBFvBa0OVvrne4kSyFCJm3xn/yOkBhuRV1qxQT3HXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk2jj4Tf; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6219375eec.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710728; x=1774315528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OO47/IfHvx9H58g5i2nmyxKJYItyb9tS+PSXsmFY7MI=;
        b=Kk2jj4TfrCsYbAv0+ipt0M69JEFO3aCj4w1vERBqVn2HKVf8muwYFlk9KSVWVnROjK
         iByPKLoj+mR+63F++JeDUxmFWOuy0I2aipyvoCOlsPchzbQNIw1v4zCb7kMOROY8AxXw
         9nZVZnWcqOcd3HMYrz5/OswiPCRN84F4mVbISo72kiJK9pefcNvb3fjQZ4ATZUBzAHuK
         86SLR3ciEhaQuwpAtY5PcdhJ+sXMoEY8ncnWE8ulRYVtckpBiq8MEfPGTpqOqKijjhPs
         IqGv+MSxgAC+Cg9FjmI+N7A8UalYFA9uPuf/DFmVfOdFlAVqQeaf6phdx7VMKnsJc2rB
         yAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710728; x=1774315528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OO47/IfHvx9H58g5i2nmyxKJYItyb9tS+PSXsmFY7MI=;
        b=GNrBX6ah9utG6Pu4jewlWxdw4uldX6m0nc8q8HYK+PAOMpWC+yLEjJChwOmtJX4sLf
         JJF5UwdKvI3rcwpeVRpmOOfUV8xMIIjS6P57XaycQbD9aC/A6uvcOnxSnz+Cyxco5NOj
         Ea1/JGE8+uAP56qGg0i3tl1vxDpWAnlBn5t9vZ/JK2Uq/zrlhY9uPFA3alHnvMSxK+83
         6yBjlXz4nSl24OxSGZqlHzh0EmYLk0o0lfNTnxQ7GTyFpT5E+MIfqAmhSwjRTBKwDhvo
         4SinmwsW0nO/3c8IOcx/o1CRkAirgqZPe0HWGL3iztkdEHF9pKn314XLvnNd7164KRm8
         wb6g==
X-Gm-Message-State: AOJu0Ywv1FjB1WRxqk+WM/vppw0eYocDS7PCSaybN8UvSFFpliOovHQY
	GifMS6rH8ZlsrazoPL3L4QTnvRjCILM66AnbKtuwIiIa8Y68OSK+zY5F
X-Gm-Gg: ATEYQzyXYG0Z3Ed2F34dF8XH7X0W+0qncUng+lQLHTxNd4eFyJKV/LF1G+5269lo02r
	fuTih/I2AyAzRhj/48EKYRgUWNaP1bxm3IEJht9QFtYQXTjErUX171IezLrEiNA6abp7iESdjIp
	BabOwPkWA8zUCMAmDm8vzQDluyO9rP/4Ifb42D/7oK2pBVkUL6cVGX0BS0YUISyEJX5wb3GPZ/d
	Sg6Wg0dfId43Vrt9d0HTMqs4hLL6ZZd1wcs65PA6RcEOFoShAduxjYYcZwmc5weg3y09j+BHU5S
	JnV6281rz9lMQA2cwRr9NIqa7KUfjrM4RPCTHniuTyfmVIzBsLz97tYsf4nRDGh/U0NNOWJFPsQ
	w40gtsFiN5NaJQWEl9n2fVN7qASu5od8SRgf3oP+I5KKbNhMC0HoeSAqmjdy8fLsuUbEE1Z7B/P
	6NzNOkM6IIERUqE7lLQ6o=
X-Received: by 2002:a05:7301:9bcb:b0:2be:2f62:8bb6 with SMTP id 5a478bee46e88-2bea553a875mr6439787eec.30.1773710727353;
        Mon, 16 Mar 2026 18:25:27 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm20268411eec.28.2026.03.16.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:25:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:25:20 +0800
From: Kevin Hao <haokexin@gmail.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Harini Katakam <harini.katakam@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: Move devm_{free,request}_irq() out of
 spin lock area
Message-ID: <abitgDJLgpLiPgap@pek-khao-d3>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
 <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xazflkdqN4rUxQSU"
Content-Disposition: inline
In-Reply-To: <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB4682A287E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xazflkdqN4rUxQSU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 07:11:34PM +0100, Th=E9o Lebrun wrote:
> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> > @@ -5962,6 +5962,7 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
> >  			/* write IP address into register */
> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> >  		}
> > +		spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  		/* Change interrupt handler and
> >  		 * Enable WoL IRQ on queue 0
> > @@ -5974,11 +5975,12 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> >  				dev_err(dev,
> >  					"Unable to request IRQ %d (error %d)\n",
> >  					bp->queues[0].irq, err);
> > -				spin_unlock_irqrestore(&bp->lock, flags);
> >  				return err;
> >  			}
> > +			spin_lock_irqsave(&bp->lock, flags);
> >  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
> >  			gem_writel(bp, WOL, tmp);
> > +			spin_unlock_irqrestore(&bp->lock, flags);
> >  		} else {
> >  			err =3D devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
> >  					       IRQF_SHARED, netdev->name, bp->queues);
> > @@ -5986,13 +5988,13 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> >  				dev_err(dev,
> >  					"Unable to request IRQ %d (error %d)\n",
> >  					bp->queues[0].irq, err);
> > -				spin_unlock_irqrestore(&bp->lock, flags);
> >  				return err;
> >  			}
> > +			spin_lock_irqsave(&bp->lock, flags);
> >  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
> >  			macb_writel(bp, WOL, tmp);
> > +			spin_unlock_irqrestore(&bp->lock, flags);
> >  		}
> > -		spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  		enable_irq_wake(bp->queues[0].irq);
> >  	}
>=20
> So it used to be that approximatively the whole macb_suspend() function
> was ran under the bp->lock spinlock. Now you split it in two to avoid
> calling IRQ functions in atomic context:
>  - (1) the disable queues & silence IRQs part and,
>  - (2) the enable WOL part (IER and WOL reg writes).
>=20
> Why do you need to grab bp->lock for the 2nd part? All queues are
> disabled anyway and IRQs masked. BH features like our work queues are
> disabled during the dev_pm_ops.suspend() calls anyway. Maybe I am
> forgetting?

You are right. I agree that the lock may not be necessary in this scenario.

> Or this was just out of caution?

This is just out of cautious consideration. Do you think I should delete th=
ese
spinlocks?

Thanks,
Kevin

--xazflkdqN4rUxQSU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmm4rYAACgkQk1jtMN6u
sXGuNAf/S9rZLmxUxfhPBdbvDTrFK3Ouf3xz5RWJo/nRinwqjA9GNlZq5qsCz7QN
tc6bJukbZumTT/Bs/oeZTeNPmo4bYMB2E1hzLctp+1FcyJF/GlybKHn+kw2/x+RV
V43LizaIOrue3Aff76w64f8c/sKI1438hvCRwuzgQfhTjKNVuAh0rz3rCn19z2Np
NBjAkXijut/cvRoUJEM7PnIItfzkhuQleIyeeWv2ylnsIzFeU+lS3BkxAastqwqj
NXynazrNpgOmhHVUS4LLFZeHNJloATK7lOicM8e6gSjvHBLwxSsEPgGVxtbtYsDX
YD3JzZsclNoDvZfj33+R80r+nj/wog==
=Dm7P
-----END PGP SIGNATURE-----

--xazflkdqN4rUxQSU--

